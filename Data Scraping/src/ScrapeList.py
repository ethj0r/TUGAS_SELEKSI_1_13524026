import json
from pathlib import Path
from playwright.sync_api import sync_playwright, Page

DirectoryUrl = "https://www.ycombinator.com/companies"
UserAgent = (
    "JorScraper-SeleksiAsistenBasdat2026 "
    "(Basis Data/Admin Basis Data/basisdata@std.stei.itb.ac.id)"
)

CompanyCardSelector = "a[class*='_company_']"
NameSelector = "[class*='_coName_']"
LocationSelector = "[class*='_coLocation_']"
PillSelector = "[class*='_tagLink_']"

OutputPath = Path(__file__).resolve().parent.parent / "data" / "RawCompanies.json"


# @desc Scroll terus sampai infinite scroll habis. stops kl count ga bertambah selama beberapa rounds
# @param TargetPage page playwright yang sudah membuka direktoriny
# @param StagnantLimit brp rounds tanpa sebelum stops
# @param ScrollPauseMs pause in (ms) setelah tiap scroll
# @return jumlah company cards terakhir yang termuat di DOM
def ScrollUntilStable(TargetPage: Page, StagnantLimit: int = 4, ScrollPauseMs: int = 1500) -> int:
    PreviousCount = 0
    StagnantRounds = 0

    while StagnantRounds < StagnantLimit:
        TargetPage.mouse.wheel(0, 20000)
        TargetPage.wait_for_timeout(ScrollPauseMs)

        CurrentCount = len(TargetPage.query_selector_all(CompanyCardSelector))
        if CurrentCount > PreviousCount:
            print(f"  termuat {CurrentCount} company...")
            PreviousCount = CurrentCount
            StagnantRounds = 0
        else:
            StagnantRounds += 1

    return PreviousCount


# @desc read teks one-liner dari card
# @param CardHandle ElementHandle satu company card
# @return string one-liner
def ReadOneLiner(CardHandle) -> str:
    Descriptor = CardHandle.query_selector("div.text-sm span, [class*='text-sm'] span")
    return Descriptor.inner_text().strip() if Descriptor else ""


# @desc intinya extract satu company card di DOM jadi raw record
# @return Dict raw record
def ExtractCard(CardHandle):
    Href = CardHandle.get_attribute("href") or ""
    Slug = Href.replace("/companies/", "").strip("/")
    if not Slug or "/" in Slug:
        return None

    NameNode = CardHandle.query_selector(NameSelector)
    LocationNode = CardHandle.query_selector(LocationSelector)
    Pills = [Pill.inner_text().strip() for Pill in CardHandle.query_selector_all(PillSelector)]

    return {
        "slug": Slug,
        "name": NameNode.inner_text().strip() if NameNode else "",
        "location": LocationNode.inner_text().strip() if LocationNode else "",
        "one_liner": ReadOneLiner(CardHandle),
        "batch": Pills[0] if Pills else "",
        "industries": Pills[1:],
    }


# @desc open direktori, scroll smpe habis, extract
# @return list raw record
def ScrapeCompanyList():
    with sync_playwright() as Runtime:
        Browser = Runtime.chromium.launch(headless=True)
        DirectoryPage = Browser.new_page(
            user_agent=UserAgent,
            viewport={"width": 1400, "height": 900},
        )

        print(f"Membuka {DirectoryUrl} ...")
        DirectoryPage.goto(DirectoryUrl, wait_until="domcontentloaded")
        DirectoryPage.wait_for_selector(CompanyCardSelector, timeout=30000)

        print("Memicu infinite scroll...")
        ScrollUntilStable(DirectoryPage)

        Cards = DirectoryPage.query_selector_all(CompanyCardSelector)
        print(f"Total kartu di DOM: {len(Cards)}. Mengekstrak...")

        SeenSlugs = set()
        RawCompanies = []
        for Card in Cards:
            Record = ExtractCard(Card)
            if Record and Record["slug"] not in SeenSlugs:
                SeenSlugs.add(Record["slug"])
                RawCompanies.append(Record)

        Browser.close()

    OutputPath.parent.mkdir(parents=True, exist_ok=True)
    OutputPath.write_text(json.dumps(RawCompanies, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"Selesai. {len(RawCompanies)} company unik -> {OutputPath}")
    return RawCompanies


if __name__ == "__main__":
    ScrapeCompanyList()
