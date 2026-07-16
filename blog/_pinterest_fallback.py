#!/usr/bin/env python3
"""
Pinterest fallback: pins every blog article that doesn't have a Pinterest pin yet.
Run as a safety fallback after each blog cycle.

Pinned slugs are tracked in blog/_pinterest_done.txt to avoid double-posting.
"""

import re
import sys
import subprocess
from pathlib import Path

REPO_DIR = Path("/home/opc/Arcbotix-Blog")
POSTS_DIR = REPO_DIR / "blog" / "posts"
DONE_FILE = REPO_DIR / "blog" / "_pinterest_done.txt"
POST_PINTEREST = REPO_DIR / "blog" / "_post_pinterest.py"

SKIP_PREFIXES = ("_", "index", "404")


def load_done() -> set:
    if DONE_FILE.exists():
        return set(DONE_FILE.read_text().splitlines())
    return set()


def save_done(done: set):
    DONE_FILE.write_text("\n".join(sorted(done)) + "\n")


def extract_meta(html_path: Path) -> tuple[str, str]:
    text = html_path.read_text(encoding="utf-8", errors="replace")

    title_match = re.search(r"<title>([^<]+)</title>", text)
    title = title_match.group(1) if title_match else ""
    title = re.sub(r"\s*[–-]\s*Arcbotix.*$", "", title).strip()

    desc_match = re.search(r'<meta\s+name="description"\s+content="([^"]+)"', text)
    description = desc_match.group(1) if desc_match else ""

    return title, description


def main():
    done = load_done()
    pinned_count = 0

    posts = sorted(POSTS_DIR.glob("*.html"), key=lambda p: p.stat().st_mtime)

    for post in posts:
        slug = post.stem

        if any(slug.startswith(p) for p in SKIP_PREFIXES):
            continue

        if slug in done:
            continue

        title, description = extract_meta(post)

        if not title or not description:
            print(f"[Pinterest-Fallback] Skipping {slug}: no title/description found.")
            done.add(slug)
            continue

        print(f"[Pinterest-Fallback] Pinning: {slug}")
        print(f"  Title: {title}")
        print(f"  Desc:  {description[:80]}...")

        result = subprocess.run(
            [sys.executable, str(POST_PINTEREST), slug, title, description],
            capture_output=True,
            text=True,
        )
        print(result.stdout)
        if result.returncode == 0:
            done.add(slug)
            pinned_count += 1
            save_done(done)
            print(f"[Pinterest-Fallback] OK: {slug}")
        elif result.returncode == 2:
            # Board not configured — abort the whole fallback, no point retrying
            print("[Pinterest-Fallback] Board not configured, skipping all pins.")
            break
        else:
            print(f"[Pinterest-Fallback] ERROR for {slug}: {result.stderr[:200]}")

    if pinned_count == 0:
        print("[Pinterest-Fallback] Nothing to pin - all articles already on Pinterest.")
    else:
        print(f"[Pinterest-Fallback] {pinned_count} new pin(s) created.")


if __name__ == "__main__":
    main()
