import psycopg

SourceDb = "yc_startup"
WarehouseDb = "yc_dwh"

QuarterBySeason = {"Winter": "Q1", "Spring": "Q2", "Summer": "Q3", "Fall": "Q4"}

def LoadDimensions(SourceCur, WhCur):
    SourceCur.execute("SELECT batch_id, season, year FROM Batch")
    BatchKey = {}
    for BatchId, Season, Year in SourceCur.fetchall():
        WhCur.execute(
            "INSERT INTO DimBatch (batch_id, season, year, quarter) VALUES (%s, %s, %s, %s) RETURNING batch_key",
            (BatchId, Season, Year, QuarterBySeason.get(Season, "Q1")),
        )
        BatchKey[BatchId] = WhCur.fetchone()[0]

    SourceCur.execute("SELECT location_id, city, state, country FROM Location")
    LocationKey = {}
    for LocationId, City, State, Country in SourceCur.fetchall():
        WhCur.execute(
            "INSERT INTO DimLocation (city, state, country) VALUES (%s, %s, %s) RETURNING location_key",
            (City, State, Country),
        )
        LocationKey[LocationId] = WhCur.fetchone()[0]

    SourceCur.execute("SELECT status_id, status_name FROM CompanyStatus")
    StatusKey = {}
    for StatusId, StatusName in SourceCur.fetchall():
        WhCur.execute(
            "INSERT INTO DimStatus (status_name) VALUES (%s) RETURNING status_key",
            (StatusName,),
        )
        StatusKey[StatusId] = WhCur.fetchone()[0]

    SourceCur.execute("SELECT industry_id, name FROM Industry")
    IndustryKey = {}
    for IndustryId, Name in SourceCur.fetchall():
        WhCur.execute(
            "INSERT INTO DimIndustry (industry_name) VALUES (%s) RETURNING industry_key",
            (Name,),
        )
        IndustryKey[IndustryId] = WhCur.fetchone()[0]

    print(f"  dimensi: {len(BatchKey)} batch, {len(LocationKey)} location, {len(StatusKey)} status, {len(IndustryKey)} industry")
    return {"batch": BatchKey, "location": LocationKey, "status": StatusKey, "industry": IndustryKey}


# @desc fill FactCompany (grain per company)
def LoadFactCompany(SourceCur, WhCur, DimKeys):
    SourceCur.execute(
        """SELECT c.slug, c.batch_id, c.location_id, c.status_id, c.team_size, c.company_age,
                  COUNT(DISTINCT f.founder_id) AS founder_count,
                  COUNT(DISTINCT ci.industry_id) AS industry_count
           FROM Company c
           LEFT JOIN Founder f ON f.company_slug = c.slug
           LEFT JOIN CompanyIndustry ci ON ci.company_slug = c.slug
           GROUP BY c.slug, c.batch_id, c.location_id, c.status_id, c.team_size, c.company_age"""
    )
    CompanyKey = {}
    for Slug, BatchId, LocationId, StatusId, TeamSize, CompanyAge, FounderCount, IndustryCount in SourceCur.fetchall():
        WhCur.execute(
            """INSERT INTO FactCompany
               (slug, batch_key, location_key, status_key, team_size, company_age, founder_count, industry_count)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING company_key""",
            (
                Slug,
                DimKeys["batch"].get(BatchId),
                DimKeys["location"].get(LocationId),
                DimKeys["status"][StatusId],
                TeamSize, CompanyAge, FounderCount, IndustryCount,
            ),
        )
        CompanyKey[Slug] = WhCur.fetchone()[0]

    print(f"  FactCompany: {len(CompanyKey)} baris")
    return CompanyKey


# @desc fill FactFounder (grain per founder)
def LoadFactFounder(SourceCur, WhCur, DimKeys):
    SourceCur.execute(
        """SELECT f.founder_id, f.name, f.company_slug,
                  c.batch_id, c.location_id, c.status_id,
                  COUNT(v.url) AS social_count,
                  COUNT(*) FILTER (WHERE v.platform = 'LinkedIn')  AS linkedin_count,
                  COUNT(*) FILTER (WHERE v.platform = 'Twitter/X') AS twitter_count,
                  COUNT(*) FILTER (WHERE v.platform = 'GitHub')    AS github_count
           FROM Founder f
           JOIN Company c ON c.slug = f.company_slug
           LEFT JOIN FounderSocialView v ON v.founder_id = f.founder_id
           GROUP BY f.founder_id, f.name, f.company_slug, c.batch_id, c.location_id, c.status_id"""
    )
    Rows = SourceCur.fetchall()
    for FounderId, Name, CompanySlug, BatchId, LocationId, StatusId, SocialCount, Linkedin, Twitter, Github in Rows:
        WhCur.execute(
            """INSERT INTO FactFounder
               (founder_name, company_slug, batch_key, location_key, status_key,
                social_count, linkedin_count, twitter_count, github_count)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)""",
            (
                Name, CompanySlug,
                DimKeys["batch"].get(BatchId),
                DimKeys["location"].get(LocationId),
                DimKeys["status"][StatusId],
                SocialCount, Linkedin, Twitter, Github,
            ),
        )
    print(f"  FactFounder: {len(Rows)} baris")


# @desc fill bridge M:N FactCompany, DimIndustry dari relasi CompanyIndustry
def LoadBridge(SourceCur, WhCur, CompanyKey, IndustryKey):
    SourceCur.execute("SELECT company_slug, industry_id FROM CompanyIndustry")
    Count = 0
    for Slug, IndustryId in SourceCur.fetchall():
        WhCur.execute(
            "INSERT INTO BridgeCompanyIndustry (company_key, industry_key) VALUES (%s, %s) ON CONFLICT DO NOTHING",
            (CompanyKey[Slug], IndustryKey[IndustryId]),
        )
        Count += 1
    print(f"  BridgeCompanyIndustry: {Count} pairing")


# @desc trincate semua tables warehouse
def TruncateWarehouse(WhCur):
    WhCur.execute(
        """TRUNCATE BridgeCompanyIndustry, FactFounder, FactCompany,
                    DimIndustry, DimStatus, DimLocation, DimBatch RESTART IDENTITY CASCADE"""
    )


def LoadAll():
    print(f"Loading warehouse '{WarehouseDb}' dari '{SourceDb}'...")
    with psycopg.connect(dbname=SourceDb) as SourceConn, psycopg.connect(dbname=WarehouseDb) as WhConn:
        with SourceConn.cursor() as SourceCur, WhConn.cursor() as WhCur:
            TruncateWarehouse(WhCur)
            DimKeys = LoadDimensions(SourceCur, WhCur)
            CompanyKey = LoadFactCompany(SourceCur, WhCur, DimKeys)
            LoadFactFounder(SourceCur, WhCur, DimKeys)
            LoadBridge(SourceCur, WhCur, CompanyKey, DimKeys["industry"])
        WhConn.commit()
    print("DONE")


if __name__ == "__main__":
    LoadAll()
