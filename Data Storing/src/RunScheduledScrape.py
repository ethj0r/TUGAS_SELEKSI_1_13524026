import subprocess
import sys
from datetime import datetime
from pathlib import Path

RepoRoot = Path(__file__).resolve().parent.parent.parent
ScrapingSrc = RepoRoot / "Data Scraping" / "src"
StoringSrc = RepoRoot / "Data Storing" / "src"

Pipeline = [
    ScrapingSrc / "ScrapeList.py",
    ScrapingSrc / "ScrapeDetail.py",
    ScrapingSrc / "Preprocess.py",
    StoringSrc / "StoreData.py",
]


# @desc run script pipeline dengan python venv yang sama
# @param ScriptPath path ke script yg di-run
def RunStage(ScriptPath: Path):
    print(f"\n{datetime.now().isoformat(timespec='seconds')}] {ScriptPath.name}", flush=True)
    Result = subprocess.run([sys.executable, "-u", str(ScriptPath)], cwd=ScriptPath.parent)
    if Result.returncode != 0:
        print(f"{ScriptPath.name} failed (exit {Result.returncode}), pipeline stopped", flush=True)
        sys.exit(Result.returncode)


# @desc run entire pipeline scraping -> preprocessing -> storing berurutan
# call manual or via cron/launchd buat automated scheduling
# ScrapeDetail.py sendiri udah resume-able (checkpoint every 25 slugs), jadi run
#yang terputus di tengah running aman dilanjutkan dengan run ulang script ini
def RunPipeline():
    StartedAt = datetime.now()
    print(f"Begin scheduled run: {StartedAt.isoformat(timespec='seconds')}", flush=True)

    for ScriptPath in Pipeline:
        RunStage(ScriptPath)

    FinishedAt = datetime.now()
    print(f"\Finish scheduled run: {FinishedAt.isoformat(timespec='seconds')} (duration {FinishedAt-StartedAt})", flush=True)


if __name__ == "__main__":
    RunPipeline()
