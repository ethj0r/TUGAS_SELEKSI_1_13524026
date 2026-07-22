# data scraping ethics yang sudah diterapkan di sini
# /companies/{slug} di allow di robots.txt (jd query string ga dipakai)
# introducing user agent yg dibuat
# udah pakai limit biar ga ngebebanin server

import json
import time
from pathlib import Path
from playwright.sync_api import sync_playwright, Page, Error as PlaywrightError

DetailUrlTemplate = "https://www.ycombinator.com/companies/{Slug}"
UserAgent = (
    "JorScraper-SeleksiAsistenBasdat2026 "
    "(Basis Data/Admin Basis Data/basisdata@std.stei.itb.ac.id)"
)

PoliteDelaySeconds = 1.2
RenderWaitMs = 3000
SaveEveryN = 25

DataDir = Path(__file__).resolve().parent.parent / "data"
InputPath = DataDir / "RawCompanies.json"
OutputPath = DataDir / "RawDetails.json"

FactLabels = ("Founded", "Team Size", "Status", "Location")
SocialDomains = ("linkedin.com/in/", "twitter.com/", "x.com/", "github.com/")


# @desc read satu blok fact berlabel (e.g., "Founded")
# @param DetailPage playwright page yg udah buka /companies/{slug}.
# @param Label fact table yang dicari, e.g,. "Team Size".
# @return val fact
def ReadFact(DetailPage: Page, Label: str) -> str:
    LabelNode = DetailPage.query_selector(
        f"xpath=//*[normalize-space(text())='{Label}:' or normalize-space(text())='{Label}']"
    )
    if not LabelNode:
        return ""
    Value = DetailPage.evaluate(
        """(Node) => {
            const Sibling = Node.nextElementSibling;
            if (Sibling && Sibling.innerText) return Sibling.innerText;
            const Parent = Node.parentElement;
            return Parent ? Parent.innerText : "";
        }""",
        LabelNode,
    )
    return (Value or "").strip()


# @desc read founder and their social link
# @param DetailPage
# @param Slug company's slug, dipakai buat membuang akun resmi company jadinya ini nanti PK
# @return List unique founder: {"name", "socials": [url, ...]}.
def ReadFounders(DetailPage: Page, Slug: str):
    Collected = DetailPage.evaluate(
        """({ SocialDomains, Slug }) => {
            const Selector = SocialDomains.map((Domain) => `a[href*='${Domain}']`).join(",");
            const ByFounder = new Map();

            document.querySelectorAll(Selector).forEach((Anchor) => {
                const Href = Anchor.getAttribute("href") || "";
                const Lower = Href.toLowerCase();
                if (Lower.includes("ycombinator")) return;              // footer YC
                if (Lower.includes(Slug.toLowerCase())) return;          // akun resmi company

                let Block = Anchor.closest("div");
                let Guard = 0;
                while (Block && Block.parentElement && Guard < 6) {
                    const Lines = (Block.innerText || "").split("\\n").map((L) => L.trim()).filter(Boolean);
                    if (Lines.length >= 2 && Block.innerText.length < 400) break;
                    Block = Block.parentElement;
                    Guard += 1;
                }
                const FounderName = Block
                    ? (Block.innerText.split("\\n").map((L) => L.trim()).filter(Boolean)[0] || "")
                    : "";
                if (!FounderName || FounderName.length > 60) return;

                if (!ByFounder.has(FounderName)) ByFounder.set(FounderName, new Set());
                ByFounder.get(FounderName).add(Href);
            });

            return [...ByFounder.entries()].map(([Name, Socials]) => ({
                name: Name,
                socials: [...Socials],
            }));
        }""",
        {"SocialDomains": list(SocialDomains), "Slug": Slug},
    )
    return Collected


# @desc read long desc dari company
# @param DetailPage
# @return desc panjang
def ReadLongDescription(DetailPage: Page) -> str:
    Longest = DetailPage.evaluate(
        """() => {
            let Best = "";
            document.querySelectorAll("p, div").forEach((Node) => {
                if (Node.children.length === 0) {
                    const Text = (Node.innerText || "").trim();
                    if (Text.length > Best.length) Best = Text;
                }
            });
            return Best;
        }"""
    )
    return (Longest or "").strip()


# @desc read URL website resmi company
# @param DetailPage
# @return URL website
def ReadWebsite(DetailPage: Page) -> str:
    Website = DetailPage.evaluate(
        """() => {
            const Skip = [
                "ycombinator", "startupschool", "workatastartup", "bookface",
                "linkedin", "twitter", "x.com", "github", "facebook", "crunchbase",
            ];
            for (const Anchor of document.querySelectorAll("a[href^='http'][target='_blank']")) {
                const Href = Anchor.getAttribute("href") || "";
                const Lower = Href.toLowerCase();
                if (Skip.some((Word) => Lower.includes(Word))) continue;
                if (Lower.includes("utm_source=yc")) continue;   // link promosi header/footer YC
                return Href;
            }
            return "";
        }"""
    )
    return (Website or "").strip()


# @desc open detail page dan jadiin seluruh field sebagai satu raw record
# @param Slug company's slug yg akan di-scrape
# @return Dict raw record buat slug terkait
def ScrapeOne(DetailPage: Page, Slug: str):
    DetailPage.goto(DetailUrlTemplate.format(Slug=Slug), wait_until="domcontentloaded")
    DetailPage.wait_for_timeout(RenderWaitMs)

    Facts = {Label: ReadFact(DetailPage, Label) for Label in FactLabels}
    return {
        "slug": Slug,
        "founded": Facts["Founded"],
        "team_size": Facts["Team Size"],
        "status": Facts["Status"],
        "location_detail": Facts["Location"],
        "website": ReadWebsite(DetailPage),
        "long_description": ReadLongDescription(DetailPage),
        "founders": ReadFounders(DetailPage, Slug),
    }


# @desc save hasil ke disk
# @param Details {slug: record} yang udh terkumpul
def SaveProgress(Details: dict):
    OutputPath.write_text(json.dumps(Details, indent=2, ensure_ascii=False), encoding="utf-8")


# @desc read slug dari sebelumnya, skip slug yg sudah
# ada di output (resume), scrape sisanya dengan wait, dan save temporary
# @return Dict {slug: record} lengkap (jg di save ke disk)
def ScrapeAllDetails():
    RawCompanies = json.loads(InputPath.read_text(encoding="utf-8"))
    Slugs = [Company["slug"] for Company in RawCompanies]

    Details = {}
    if OutputPath.exists():
        Details = json.loads(OutputPath.read_text(encoding="utf-8"))
        print(f"Melanjutkan: {len(Details)} slug sudah ada, dilewati.")

    Pending = [Slug for Slug in Slugs if Slug not in Details]
    print(f"Total {len(Slugs)} slug, {len(Pending)} perlu di-scrape.")

    with sync_playwright() as Runtime:
        Browser = Runtime.chromium.launch(headless=True)
        DetailPage = Browser.new_page(
            user_agent=UserAgent,
            viewport={"width": 1400, "height": 900},
        )

        for Index, Slug in enumerate(Pending, start=1):
            try:
                Details[Slug] = ScrapeOne(DetailPage, Slug)
            except PlaywrightError as Failure:
                print(f"  [!] gagal {Slug}: {Failure}")
                Details[Slug] = {"slug": Slug, "error": str(Failure)}

            if Index % SaveEveryN == 0:
                SaveProgress(Details)
                print(f"  {Index}/{len(Pending)} selesai (checkpoint disimpan)")

            time.sleep(PoliteDelaySeconds)

        Browser.close()

    SaveProgress(Details)
    print(f"Selesai. {len(Details)} record detail -> {OutputPath}")
    return Details


if __name__ == "__main__":
    ScrapeAllDetails()
