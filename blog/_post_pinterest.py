#!/usr/bin/env python3
"""
Create a Pinterest pin for a new Arcbotix blog article.
=========================================================
Uses the Postiz API (same mechanism as the Nachhilfe-Mentor blog agent)
to post the blog's cover image as a pin with a link back to the article.

Usage:
  python3 blog/_post_pinterest.py <SLUG> "<TITLE>" "<DESCRIPTION>"

Called automatically by arcbotix-blog.sh's Pinterest safety fallback
after each blog cycle.
"""

import sys
import os
from datetime import datetime, timezone
from pathlib import Path

import requests

REPO_DIR = Path(__file__).resolve().parents[1]
ENV_FILE = REPO_DIR / ".env"


def load_env():
    values = {}
    if ENV_FILE.exists():
        for line in ENV_FILE.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, _, value = line.partition("=")
            values[key.strip()] = value.strip()
    return values


ENV = load_env()
POSTIZ_API_KEY = ENV.get("POSTIZ_API_KEY", "")
POSTIZ_BASE_URL = "https://api.postiz.com/public/v1"
PINTEREST_ID = ENV.get("PINTEREST_INTEGRATION_ID", "")
SITE_URL = "https://arcbotix.com"
BLOG_DIR = str(REPO_DIR / "blog" / "posts")

# No dedicated board configured yet - Postiz falls back to the account's default board.
PINTEREST_BOARD = ""

MIME_TYPES = {
    ".webp": "image/webp",
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
}


def auth_headers(extra=None):
    h = {"Authorization": POSTIZ_API_KEY}
    if extra:
        h.update(extra)
    return h


def upload_image(file_path):
    """Uploads an image to the Postiz API (multipart/form-data)."""
    ext = os.path.splitext(file_path)[1].lower()
    mime = MIME_TYPES.get(ext, "image/png")
    filename = os.path.basename(file_path)

    print(f"[Pinterest] Uploading {filename} ({mime})...")
    with open(file_path, "rb") as f:
        resp = requests.post(
            f"{POSTIZ_BASE_URL}/upload",
            headers={"Authorization": POSTIZ_API_KEY},
            files={"file": (filename, f, mime)},
            timeout=60,
        )

    if resp.status_code not in (200, 201):
        print(f"[Pinterest] Upload error: {resp.status_code} {resp.text[:300]}")
        return None

    result = resp.json()
    print(f"[Pinterest] Upload OK: id={result.get('id')}")
    return result


def create_pin(image_ref, title, description, link):
    """Creates a Pinterest pin (same payload shape as the Nachhilfe-Mentor agent)."""
    settings = {
        "__type": "pinterest",
        "title": title[:100],
    }
    if link:
        settings["link"] = link
    if PINTEREST_BOARD:
        settings["board"] = PINTEREST_BOARD

    post_entry = {
        "integration": {"id": PINTEREST_ID},
        "value": [{"content": description, "image": [image_ref]}],
        "settings": settings,
    }

    payload = {
        "type": "now",
        "date": datetime.now(timezone.utc).isoformat(),
        "shortLink": False,
        "tags": [],
        "posts": [post_entry],
    }

    resp = requests.post(
        f"{POSTIZ_BASE_URL}/posts",
        headers=auth_headers({"Content-Type": "application/json"}),
        json=payload,
        timeout=30,
    )

    if resp.status_code not in (200, 201):
        print(f"[Pinterest] Post error: {resp.status_code} {resp.text[:300]}")
        return None

    result = resp.json()
    if isinstance(result, list) and len(result) > 0:
        post_id = result[0].get("postId") or result[0].get("id", "?")
    elif isinstance(result, dict):
        post_id = result.get("postId") or result.get("id", "?")
    else:
        post_id = str(result)[:50]
    print(f"[Pinterest] Pin created! Post ID: {post_id}")
    return post_id


def main():
    if len(sys.argv) < 4:
        print('Usage: python3 _post_pinterest.py <SLUG> "<TITLE>" "<DESCRIPTION>"')
        sys.exit(1)

    if not POSTIZ_API_KEY or not PINTEREST_ID:
        print("[Pinterest] Missing POSTIZ_API_KEY or PINTEREST_INTEGRATION_ID in .env, aborting.")
        sys.exit(1)

    slug = sys.argv[1]
    title = sys.argv[2]
    description = sys.argv[3]

    image_path = None
    for ext in ["webp", "png", "jpg"]:
        candidate = os.path.join(BLOG_DIR, "img", f"{slug}.{ext}")
        if os.path.exists(candidate):
            image_path = candidate
            break

    if not image_path:
        print(f"[Pinterest] No image found for slug: {slug}")
        print(f"[Pinterest] Looked in: {BLOG_DIR}/img/{slug}.[webp|png|jpg]")
        sys.exit(1)

    link = f"{SITE_URL}/blog/posts/{slug}.html"

    print(f"[Pinterest] Creating pin for: {title}")
    print(f"[Pinterest] Image: {image_path}")
    print(f"[Pinterest] Link: {link}")

    upload_result = upload_image(image_path)
    if not upload_result or "id" not in upload_result:
        print("[Pinterest] Image upload failed, aborting.")
        sys.exit(1)

    image_ref = {"id": upload_result["id"], "path": upload_result["path"]}

    pin_description = (
        f"{description}\n\n"
        f"Read it on arcbotix.com\n\n"
        f"#Robotics #RoboticsEngineering #ControlSystems #Arcbotix #Engineering #Mechatronics"
    )

    post_id = create_pin(image_ref, title, pin_description, link)
    if post_id:
        print(f"[Pinterest] Success! Pin ID: {post_id}")
    else:
        print("[Pinterest] Pin creation failed.")
        sys.exit(1)


if __name__ == "__main__":
    main()
