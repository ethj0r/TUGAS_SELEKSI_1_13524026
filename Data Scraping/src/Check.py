#buat cek apakah align dengan robots.txt
import urllib.robotparser

ROBOTS_URL = "https://www.ycombinator.com/robots.txt"
USER_AGENT = "JorScraper-SeleksiAsistenBasdat2026"

TARGET_URLS = [
    "https://www.ycombinator.com/companies",
    "https://www.ycombinator.com/companies/airbnb",
    "https://www.ycombinator.com/companies?batch=Winter%202025",
    "https://www.ycombinator.com/companies?industry=Fintech",
]

rp = urllib.robotparser.RobotFileParser()
rp.set_url(ROBOTS_URL)
rp.read()

for url in TARGET_URLS:
    allowed = rp.can_fetch(USER_AGENT, url)
    print(f"{'ALLOWED ' if allowed else 'DILARANG  '} -> {url}")