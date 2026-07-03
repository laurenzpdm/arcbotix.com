#!/usr/bin/env python3
"""
SEO automation for the RoboWire blog (preview build).
======================================================
Generates sitemap.xml and feed.xml from the existing HTML files.

Usage:
  python3 blog/_update_seo.py                # Generate sitemap + feed
  python3 blog/_update_seo.py --ping         # Also submit to IndexNow (only use once a real domain is live)

IndexNow submission defaults to OFF in this preview build: the site is served
from a temporary tunnel URL that changes on restart, so submitting it to real
search engines would be pointless (and would need re-doing once a real domain
is chosen). Pass --ping explicitly once RoboWire has a permanent domain.
"""

import os
import re
import sys
import glob
import json
import urllib.request
import urllib.error
from datetime import datetime, timezone

SITE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DOMAIN_FILE = os.path.join(SITE_DIR, "DOMAIN.txt")
SITEMAP_PATH = os.path.join(SITE_DIR, "sitemap.xml")
FEED_PATH = os.path.join(SITE_DIR, "feed.xml")
INDEXNOW_KEY = "robowire2026indexnow"


def site_url():
    if os.path.exists(DOMAIN_FILE):
        value = open(DOMAIN_FILE, encoding="utf-8").read().strip()
        if value:
            return value.rstrip("/")
    return "https://robowire.preview"


def get_lastmod(filepath):
    mtime = os.path.getmtime(filepath)
    return datetime.fromtimestamp(mtime).strftime("%Y-%m-%d")


def get_rfc822_date(filepath):
    mtime = os.path.getmtime(filepath)
    dt = datetime.fromtimestamp(mtime, tz=timezone.utc)
    return dt.strftime("%a, %d %b %Y %H:%M:%S +0000")


def extract_meta(filepath, attr_name):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read(8000)
        pattern = rf'<meta\s+(?:name|property)="{re.escape(attr_name)}"\s+content="([^"]*)"'
        match = re.search(pattern, content)
        if match:
            return match.group(1)
    except Exception:
        pass
    return ""


def extract_title(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read(4000)
        match = re.search(r"<title>([^<]+)</title>", content)
        if match:
            title = match.group(1)
            title = re.sub(r"\s*[–—–—]\s*RoboWire.*$", "", title)
            return title.strip()
    except Exception:
        pass
    return ""


def extract_category(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read(10000)
        match = re.search(r'class="blog-tag[^"]*">([^<]+)<', content)
        if match:
            return match.group(1).strip()
    except Exception:
        pass
    return "Robotics"


def scan_pages():
    pages = {"main": [], "blog_index": None, "blog_posts": []}

    index = os.path.join(SITE_DIR, "index.html")
    if os.path.exists(index):
        pages["main"].append(("", index, 1.0, "weekly"))

    blog_index = os.path.join(SITE_DIR, "blog", "index.html")
    if os.path.exists(blog_index):
        pages["blog_index"] = ("blog/", blog_index, 0.9, "daily")

    posts_dir = os.path.join(SITE_DIR, "blog", "posts")
    if os.path.isdir(posts_dir):
        for f in sorted(glob.glob(os.path.join(posts_dir, "*.html"))):
            basename = os.path.basename(f)
            path = f"blog/posts/{basename}"
            pages["blog_posts"].append((path, f, 0.7, "monthly"))

    return pages


def generate_sitemap(pages, site_url_value):
    urls = []
    all_pages = pages["main"][:]
    if pages["blog_index"]:
        all_pages.append(pages["blog_index"])
    all_pages.extend(pages["blog_posts"])

    for path, filepath, priority, changefreq in all_pages:
        loc = f"{site_url_value}/{path}" if path else f"{site_url_value}/"
        lastmod = get_lastmod(filepath)
        urls.append(
            f"  <url>\n"
            f"    <loc>{loc}</loc>\n"
            f"    <lastmod>{lastmod}</lastmod>\n"
            f"    <changefreq>{changefreq}</changefreq>\n"
            f"    <priority>{priority}</priority>\n"
            f"  </url>"
        )

    xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
        + "\n".join(urls)
        + "\n</urlset>\n"
    )

    with open(SITEMAP_PATH, "w", encoding="utf-8") as f:
        f.write(xml)

    print(f"[SEO] sitemap.xml generated: {len(urls)} URLs")
    return len(urls)


def generate_feed(pages, site_url_value):
    now = datetime.now(tz=timezone.utc).strftime("%a, %d %b %Y %H:%M:%S +0000")

    blog_pages = sorted(pages["blog_posts"], key=lambda p: os.path.getmtime(p[1]), reverse=True)

    items = []
    for path, filepath, _, _ in blog_pages[:20]:
        title = extract_title(filepath)
        description = extract_meta(filepath, "description")
        category = extract_category(filepath)
        pub_date = get_rfc822_date(filepath)
        link = f"{site_url_value}/{path}"

        title = title.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        description = description.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

        items.append(
            f"    <item>\n"
            f"      <title>{title}</title>\n"
            f"      <link>{link}</link>\n"
            f"      <guid>{link}</guid>\n"
            f"      <pubDate>{pub_date}</pubDate>\n"
            f"      <description>{description}</description>\n"
            f"      <category>{category}</category>\n"
            f"    </item>"
        )

    xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">\n'
        "  <channel>\n"
        "    <title>RoboWire</title>\n"
        f"    <link>{site_url_value}/blog/</link>\n"
        "    <description>Practical robotics engineering guides and niche technical deep-dives</description>\n"
        "    <language>en-us</language>\n"
        f"    <lastBuildDate>{now}</lastBuildDate>\n"
        f'    <atom:link href="{site_url_value}/feed.xml" rel="self" type="application/rss+xml"/>\n'
        + "\n".join(items)
        + "\n  </channel>\n"
        "</rss>\n"
    )

    with open(FEED_PATH, "w", encoding="utf-8") as f:
        f.write(xml)

    print(f"[SEO] feed.xml generated: {len(items)} articles")
    return len(items)


def submit_indexnow(changed_urls, site_url_value):
    if not changed_urls:
        print("[SEO] IndexNow: nothing to submit")
        return True

    host = site_url_value.split("//", 1)[-1]
    key_file = os.path.join(SITE_DIR, f"{INDEXNOW_KEY}.txt")
    if not os.path.exists(key_file):
        with open(key_file, "w") as f:
            f.write(INDEXNOW_KEY)
        print(f"[SEO] Created IndexNow key file: {INDEXNOW_KEY}.txt")

    payload = json.dumps({
        "host": host,
        "key": INDEXNOW_KEY,
        "keyLocation": f"{site_url_value}/{INDEXNOW_KEY}.txt",
        "urlList": changed_urls[:10000],
    }).encode("utf-8")

    try:
        req = urllib.request.Request("https://api.indexnow.org/indexnow", data=payload, method="POST")
        req.add_header("Content-Type", "application/json; charset=utf-8")
        req.add_header("User-Agent", "RoboWire-SEO-Bot/1.0")
        with urllib.request.urlopen(req, timeout=15) as resp:
            print(f"[SEO] IndexNow: HTTP {resp.status} - {len(changed_urls)} URLs submitted")
            return resp.status in (200, 202)
    except urllib.error.HTTPError as e:
        print(f"[SEO] IndexNow HTTP error: {e.code} {e.reason}")
        return False
    except Exception as e:
        print(f"[SEO] IndexNow failed: {e}")
        return False


def main():
    do_ping = "--ping" in sys.argv
    site_url_value = site_url()

    print(f"[SEO] Building SEO files for {site_url_value}")
    pages = scan_pages()
    url_count = generate_sitemap(pages, site_url_value)
    article_count = generate_feed(pages, site_url_value)

    if do_ping:
        all_urls = [f"{site_url_value}/{p[0]}" for p in pages["blog_posts"]]
        all_urls.append(f"{site_url_value}/")
        if pages["blog_index"]:
            all_urls.append(f"{site_url_value}/blog/")
        print(f"[SEO] Submitting {len(all_urls)} URLs to IndexNow...")
        submit_indexnow(all_urls, site_url_value)
    else:
        print("[SEO] IndexNow submit skipped (preview build - pass --ping once on a real domain)")

    print(f"[SEO] Done. {url_count} URLs in sitemap, {article_count} articles in feed.")


if __name__ == "__main__":
    main()
