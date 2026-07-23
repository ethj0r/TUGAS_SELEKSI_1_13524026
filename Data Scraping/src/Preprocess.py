import json
import re
from pathlib import Path

CurrentYear = 2026 #buat derivedd company_age nanti

DataDir = Path(__file__).resolve().parent.parent / "data"
RawCompaniesPath = DataDir / "RawCompanies.json"
RawDetailsPath = DataDir / "RawDetails.json"

KnownSeasons = ("Winter", "Spring", "Summer", "Fall")
SeasonCode = {"Winter": "Wi", "Spring": "Sp", "Summer": "Su", "Fall": "Fa"}
FactLabelNames = ("Founded", "Batch", "Team Size", "Status", "Location")


# @desc parse kode batch YC ("SPRING 2026") jadi season & year.
# @param RawBatch string batch raw dari card. e.g., "SUMMER 2013".
# @return (Season, Year)
def ParseBatch(RawBatch: str):
    if not RawBatch:
        return None, None
    Parts = RawBatch.strip().split()
    Season = Parts[0].capitalize() if Parts else None
    Year = int(Parts[1]) if len(Parts) > 1 and Parts[1].isdigit() else None
    if Season not in KnownSeasons:
        Season = None
    return Season, Year


# @desc parse string lokasi "San Francisco, CA, USA" jadi city/state/country.
# @param RawLocation string raw location
# @return Dict {"city", "state", "country"}
def ParseLocation(RawLocation: str):
    if not RawLocation:
        return {"city": None, "state": None, "country": None}
    Segments = [Segment.strip() for Segment in RawLocation.split(",") if Segment.strip()]
    if len(Segments) >= 3:
        return {"city": Segments[0], "state": Segments[1], "country": Segments[-1]}
    if len(Segments) == 2:
        return {"city": Segments[0], "state": None, "country": Segments[1]}
    if len(Segments) == 1:
        return {"city": Segments[0], "state": None, "country": None}
    return {"city": None, "state": None, "country": None}


# @desc string num jadi int
# @param RawValue raw stting num, e.g., "8600".
# @return raw val int
def ToIntOrNone(RawValue: str):
    if RawValue and str(RawValue).strip().isdigit():
        return int(str(RawValue).strip())
    return None


# @desc normalize nama industri (raw datanya UPPERCASE e.g., "FOOD AND BEVERAGE").
# @param RawIndustry
# @return nama industri Title Case.
def NormalizeIndustry(RawIndustry: str) -> str:
    return RawIndustry.strip().title()


# @desc intinya detect platform social dari domain URL, dipakai as atribut deskriptif
# di weak entities FounderSocial. Twitter/x.com digabung "Twitter/X".
# @param SocialUrl URL social founder.
# @return platform name, e.g., "LinkedIn" | "Twitter/X" | "GitHub" | "Other".
def DetectPlatform(SocialUrl: str) -> str:
    Lower = SocialUrl.lower()
    if "linkedin.com" in Lower:
        return "LinkedIn"
    if "twitter.com" in Lower or "x.com" in Lower:
        return "Twitter/X"
    if "github.com" in Lower:
        return "GitHub"
    return "Other"


# @desc clean whitespace
# @param RawText ya raw text aja
# @return one space text
def CleanText(RawText: str):
    if not RawText:
        return None
    Collapsed = re.sub(r"\s+", " ", RawText.replace("\xa0", " ")).strip()
    return Collapsed or None

# @desc cek nama founder valid
# @param Name founder yang sudah di-lcean
# @return True kalau aman
def IsValidFounderName(Name: str) -> bool:
    if not Name:
        return False
    if Name.endswith(":"):
        return False
    if Name in FactLabelNames:
        return False
    return True


# @desc run seluruh preprocessing
# merge dua source, transform, build entties relasional terpisah
# company yang gagal di-scrape ku putuskan buang aja biar dataset finalnya nanti clean
# @return Dict {NamaFile: ListRecord}
def BuildEntities():
    RawCompanies = json.loads(RawCompaniesPath.read_text(encoding="utf-8"))
    RawDetails = json.loads(RawDetailsPath.read_text(encoding="utf-8"))

    Companies = []
    Batches = {}
    Industries = {}
    CompanyIndustries = []
    Founders = []
    FounderSocials = []

    NextFounderId = 1

    for Company in RawCompanies:
        Slug = Company["slug"]
        Detail = RawDetails.get(Slug, {})
        if Detail.get("error"):
            continue

        Season, Year = ParseBatch(Company["batch"])
        if Season and Year and (Season, Year) not in Batches:
            Batches[(Season, Year)] = {
                "batch_id": f"{SeasonCode[Season]}{str(Year)[2:]}",
                "season": Season,
                "year": Year,
            }

        Location = ParseLocation(Company["location"] or Detail.get("location_detail", ""))
        FoundedYear = ToIntOrNone(Detail.get("founded", ""))

        Companies.append({
            "slug": Slug,
            "name": CleanText(Company["name"]),
            "one_liner": CleanText(Company["one_liner"]),
            "long_description": CleanText(Detail.get("long_description")),
            "website": Detail.get("website") or None,
            "status": Detail.get("status") or None,
            "team_size": ToIntOrNone(Detail.get("team_size", "")),
            "founded_year": FoundedYear,
            "company_age": (CurrentYear - FoundedYear) if FoundedYear else None, #derived
            "batch_id": Batches[(Season, Year)]["batch_id"] if (Season, Year) in Batches else None,
            "city": Location["city"],
            "state": Location["state"],
            "country": Location["country"],
        })

        for RawIndustry in Company["industries"]:
            IndustryName = NormalizeIndustry(RawIndustry)
            if IndustryName not in Industries:
                Industries[IndustryName] = {
                    "industry_id": len(Industries) + 1,
                    "name": IndustryName,
                }
            CompanyIndustries.append({
                "company_slug": Slug,
                "industry_id": Industries[IndustryName]["industry_id"],
            })

        for FounderRecord in Detail.get("founders", []):
            FounderName = CleanText(FounderRecord.get("name"))
            if not IsValidFounderName(FounderName):
                continue
            Founders.append({
                "founder_id": NextFounderId,
                "company_slug": Slug,
                "name": FounderName,
            })
            for SocialUrl in FounderRecord.get("socials", []):
                FounderSocials.append({
                    "founder_id": NextFounderId,
                    "platform": DetectPlatform(SocialUrl),
                    "url": SocialUrl,
                })
            NextFounderId += 1

    return {
        "companies.json": Companies,
        "batches.json": list(Batches.values()),
        "industries.json": list(Industries.values()),
        "company_industries.json": CompanyIndustries,
        "founders.json": Founders,
        "founder_socials.json": FounderSocials,
    }


# @desc write each entitas ke JSON file
# @param entities Dict {NamaFile: ListRecord} BuildEntities.
def WriteEntities(Entities: dict):
    for FileName, Records in Entities.items():
        (DataDir / FileName).write_text(
            json.dumps(Records, indent=2, ensure_ascii=False), encoding="utf-8"
        )
        print(f"  {FileName:26s}: {len(Records)} record")


if __name__ == "__main__":
    print("PREPROCESSING HASIL SCRAPING")
    Result = BuildEntities()
    WriteEntities(Result)
    print("DONE.")
