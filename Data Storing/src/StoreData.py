import json
from pathlib import Path

import psycopg

DatabaseName = "yc_startup"

ScrapingDataDir = Path(__file__).resolve().parent.parent.parent / "Data Scraping" / "data"

StatusCatalog = [
    (1, "Active"),
    (2, "Acquired"),
    (3, "Public"),
    (4, "Inactive"),
]
StatusIdByName = {Name: StatusId for StatusId, Name in StatusCatalog}
IsaTableByStatus = {
    "Active": "ActiveCompany",
    "Acquired": "AcquiredCompany",
    "Public": "PublicCompany",
    "Inactive": "InactiveCompany",
}

def LoadEntity(FileName: str):
    return json.loads((ScrapingDataDir / FileName).read_text(encoding="utf-8"))


# @desc create new ScrapeSession row
# @param Cursor psycopg aktif dalam transaksi
# @return session_id row yang baru dibuat
def StartSession(Cursor) -> int:
    Cursor.execute("SELECT COALESCE(MAX(session_number), 0) + 1 FROM ScrapeSession")
    NextNumber = Cursor.fetchone()[0]
    Cursor.execute(
        "INSERT INTO ScrapeSession (session_number) VALUES (%s) RETURNING session_id, started_at",
        (NextNumber,),
    )
    SessionId, StartedAt = Cursor.fetchone()
    print(f"  ScrapeSession #{NextNumber} dibuka (session_id={SessionId}, started_at={StartedAt})")
    return SessionId


# @desc fill/refresh tabel ref yang idempotent by nature e.g., Batch, Industry,CompanyStat
def UpsertReferenceTables(Cursor):
    Cursor.executemany(
        """INSERT INTO CompanyStatus (status_id, status_name) VALUES (%s, %s)
           ON CONFLICT (status_id) DO NOTHING""",
        StatusCatalog,
    )

    Batches = LoadEntity("batches.json")
    Cursor.executemany(
        """INSERT INTO Batch (batch_id, season, year) VALUES (%(batch_id)s, %(season)s, %(year)s)
           ON CONFLICT (batch_id) DO NOTHING""",
        Batches,
    )

    Industries = LoadEntity("industries.json")
    Cursor.executemany(
        """INSERT INTO Industry (name) VALUES (%(name)s)
           ON CONFLICT (name) DO NOTHING""",
        Industries,
    )
    print(f"  referensi: {len(Batches)} batch, {len(Industries)} industry, {len(StatusCatalog)} status")


# @desc fill/refresh tabel Lokasi dari kombinasi city/state/country unique pada
# companies.json dan return mapping (city, state, country) -> location_id
# @param Companie record list company
# @return Dict {(city, state, country): location_id}
def UpsertLocations(Cursor, Companies):
    UniqueLocations = sorted({
        (Company["city"], Company["state"], Company["country"])
        for Company in Companies
        if Company["city"]
    }, key=lambda Triple: tuple("" if Part is None else Part for Part in Triple))

    LocationId = {}
    for City, State, Country in UniqueLocations:
        Cursor.execute(
            """INSERT INTO Location (city, state, country) VALUES (%s, %s, %s)
               ON CONFLICT (city, COALESCE(state, ''), COALESCE(country, ''))
               DO UPDATE SET city = EXCLUDED.city
               RETURNING location_id""",
            (City, State, Country),
        )
        LocationId[(City, State, Country)] = Cursor.fetchone()[0]

    print(f"  lokasi: {len(LocationId)} kombinasi unik")
    return LocationId


# @desc move slug ke subtipe ISA yg sesuai status barunya, dan delet
# subtipe lama jika status berubah antar-run (e.g., Active -> Acquired)
# @param Status nama status baru ("Active"/"Acquired"/"Public"/"Inactive").
def ReconcileIsaSubtype(Cursor, Slug: str, Status: str):
    TargetTable = IsaTableByStatus[Status]
    for TableName in IsaTableByStatus.values():
        if TableName != TargetTable:
            Cursor.execute(f"DELETE FROM {TableName} WHERE slug = %s", (Slug,))
    Cursor.execute(
        f"INSERT INTO {TargetTable} (slug) VALUES (%s) ON CONFLICT (slug) DO NOTHING",
        (Slug,),
    )


# @desc upsert satu row Company (by slug) dan link ke session scraping running
# dan company_age tidak dikirim (krn udah diisi trigger)
def UpsertCompany(Cursor, Company: dict, LocationId: dict, SessionId: int):
    Cursor.execute(
        """INSERT INTO Company
           (slug, name, one_liner, long_description, website, team_size,
            founded_year, batch_id, location_id, status_id, session_id)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
           ON CONFLICT (slug) DO UPDATE SET
               name              = EXCLUDED.name,
               one_liner         = EXCLUDED.one_liner,
               long_description  = EXCLUDED.long_description,
               website           = EXCLUDED.website,
               team_size         = EXCLUDED.team_size,
               founded_year      = EXCLUDED.founded_year,
               batch_id          = EXCLUDED.batch_id,
               location_id       = EXCLUDED.location_id,
               status_id         = EXCLUDED.status_id,
               session_id        = EXCLUDED.session_id""",
        (
            Company["slug"], Company["name"], Company["one_liner"],
            Company["long_description"], Company["website"], Company["team_size"],
            Company["founded_year"], Company["batch_id"],
            LocationId.get((Company["city"], Company["state"], Company["country"])),
            StatusIdByName[Company["status"]], SessionId,
        ),
    )
    ReconcileIsaSubtype(Cursor, Company["slug"], Company["status"])


# @desc upsert relasi M:N CompanyIndustry buat satu company
# di sini pake DELETE lalu INSERT ulang biar industri yang udah ga berlaku lagi
# di run terbaru ga nyangkut jadi data artifacts
def ReplaceCompanyIndustries(Cursor, Slug: str, IndustryNames: list):
    Cursor.execute("DELETE FROM CompanyIndustry WHERE company_slug = %s", (Slug,))
    if not IndustryNames:
        return
    Cursor.executemany(
        """INSERT INTO CompanyIndustry (company_slug, industry_id)
           SELECT %s, industry_id FROM Industry WHERE name = %s""",
        [(Slug, Name) for Name in IndustryNames],
    )


# @desc upsert Founder + FounderSocial (weak entity) buat satu company
# founder di sini di-resolve by (company_slug, name) karena sumber scraping ga punya ID founder yang pas/cocok
def ReplaceFoundersAndSocials(Cursor, Slug: str, Founders: list):
    Cursor.execute(
        "SELECT founder_id FROM Founder WHERE company_slug = %s",
        (Slug,),
    )
    ExistingFounderIds = [Row[0] for Row in Cursor.fetchall()]
    if ExistingFounderIds:
        Cursor.execute(
            "DELETE FROM FounderSocial WHERE founder_id = ANY(%s)",
            (ExistingFounderIds,),
        )
    Cursor.execute("DELETE FROM Founder WHERE company_slug = %s", (Slug,))

    for FounderRecord in Founders:
        Name = FounderRecord["name"]
        Cursor.execute(
            "INSERT INTO Founder (company_slug, name) VALUES (%s, %s) RETURNING founder_id",
            (Slug, Name),
        )
        FounderId = Cursor.fetchone()[0]
        Socials = FounderRecord.get("socials", [])
        if Socials:
            Cursor.executemany(
                "INSERT INTO FounderSocial (founder_id, url) VALUES (%s, %s)",
                [(FounderId, Url) for Url in Socials],
            )


# @desc main func, intinya run seluruh storing process (upsert, bukan insert raw)
# aman di-run berulang (e.g., lewat cron) tanpa menghasilkan duplicates row
# dan kalau ada error, bakal langsung di rollback
def StoreAll():
    Companies = LoadEntity("companies.json")
    CompanyIndustries = LoadEntity("company_industries.json")
    IndustriesByCompany = {}
    for Row in CompanyIndustries:
        IndustriesByCompany.setdefault(Row["company_slug"], []).append(Row["industry_id"])

    RawIndustries = LoadEntity("industries.json")
    IndustryNameById = {Row["industry_id"]: Row["name"] for Row in RawIndustries}

    RawFounders = LoadEntity("founders.json")
    RawSocials = LoadEntity("founder_socials.json")
    SocialsByFounderId = {}
    for Row in RawSocials:
        SocialsByFounderId.setdefault(Row["founder_id"], []).append(Row["url"])

    FoundersByCompany = {}
    for Row in RawFounders:
        FoundersByCompany.setdefault(Row["company_slug"], []).append({
            "name": Row["name"],
            "socials": SocialsByFounderId.get(Row["founder_id"], []),
        })

    print(f"Meng-upsert {len(Companies)} company ke database '{DatabaseName}'...")

    with psycopg.connect(dbname=DatabaseName) as Connection:
        with Connection.cursor() as Cursor:
            SessionId = StartSession(Cursor)
            UpsertReferenceTables(Cursor)
            LocationId = UpsertLocations(Cursor, Companies)

            for Company in Companies:
                Slug = Company["slug"]
                UpsertCompany(Cursor, Company, LocationId, SessionId)
                ReplaceCompanyIndustries(
                    Cursor, Slug,
                    [IndustryNameById[Id] for Id in IndustriesByCompany.get(Slug, [])],
                )
                ReplaceFoundersAndSocials(Cursor, Slug, FoundersByCompany.get(Slug, []))

        Connection.commit()

    print(f"  company: {len(Companies)} row upsert")
    print(f"  m:n & founder: {len(CompanyIndustries)} company_industry, {len(RawFounders)} founder, {len(RawSocials)} social")
    print("DONE")


if __name__ == "__main__":
    StoreAll()
