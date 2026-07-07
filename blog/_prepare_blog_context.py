#!/usr/bin/env python3
"""Build a compact context file for the autonomous Arcbotix blog writer.

Claude should not reread the full registry and strategy on every run. This
script extracts only the parts needed for safe topic selection and quality.
"""

from __future__ import annotations

import re
from pathlib import Path


REPO_DIR = Path(__file__).resolve().parents[1]
BLOG_DIR = REPO_DIR / "blog"
REGISTRY = BLOG_DIR / "_BLOG_REGISTRY.md"
STRATEGY = BLOG_DIR / "_BLOG_STRATEGY.md"
OUT = BLOG_DIR / "_BLOG_CONTEXT_COMPACT.md"
NOTES = BLOG_DIR / "_BLOG_CONTEXT_NOTES.md"


def section(text: str, heading: str) -> str:
    pattern = rf"(^## {re.escape(heading)}\n.*?)(?=^## |\Z)"
    match = re.search(pattern, text, flags=re.M | re.S)
    return match.group(1).strip() if match else ""


def latest_article_rows(registry: str, limit: int = 45) -> list[str]:
    rows = []
    in_table = False
    for line in registry.splitlines():
        if line.startswith("| # | Date | Slug |"):
            in_table = True
            continue
        if in_table and line.startswith("|---"):
            continue
        if in_table:
            if not line.startswith("|"):
                break
            # Drop the summary column - Claude only needs slug + date for the duplicate check.
            parts = line.rstrip(" |").split("|")
            rows.append("|".join(parts[:-1]) + " |")
            if len(rows) >= limit:
                break
    return rows


def all_slugs(registry: str) -> list[str]:
    slugs: list[str] = []
    for line in registry.splitlines():
        if not line.startswith("| "):
            continue
        parts = [part.strip() for part in line.strip("|").split("|")]
        if len(parts) >= 4 and parts[0].isdigit() and re.match(r"^[a-z0-9-]+$", parts[2]):
            slugs.append(parts[2])
    return slugs


def main() -> None:
    registry = REGISTRY.read_text(encoding="utf-8")
    strategy = STRATEGY.read_text(encoding="utf-8")
    slugs = all_slugs(registry)

    parts = [
        "# Compact Blog Context",
        "",
        "This file is auto-generated. Read this instead of the full registry/strategy.",
        "",
        "## Stats",
        section(registry, "Stats").replace("## Stats\n", "").strip(),
        f"- Known slugs: {len(slugs)}",
        "",
        "## Current Strategy",
        section(strategy, "Goal").replace("## Goal\n", "").strip(),
        "",
        section(strategy, "Content Guidelines").strip(),
        "",
        section(strategy, "Topic Strategy").strip(),
        "",
        "## Extra Notes",
        NOTES.read_text(encoding="utf-8").strip() if NOTES.exists() else "",
        "",
        "## Recent Articles",
        "| # | Date | Slug | Title | Keywords | Tag |",
        "|---|------|------|-------|----------|-----|",
        *latest_article_rows(registry),
        "",
        "## Keyword Pool",
        section(registry, "Keyword Pool (not yet used)").strip(),
        "",
        "## Slugs Already Used",
        ", ".join(slugs),
        "",
        "## Image Prompt Style",
        section(strategy, "Image Prompt Style").strip(),
        "",
    ]
    OUT.write_text("\n".join(part for part in parts if part is not None), encoding="utf-8")
    print(f"[Context] Wrote {OUT.relative_to(REPO_DIR)} ({OUT.stat().st_size} bytes)")


if __name__ == "__main__":
    main()
