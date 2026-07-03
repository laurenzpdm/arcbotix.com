#!/usr/bin/env bash
# Auto-Blog Engine for RoboWire (robotics blog, English, preview build)
# Mirrors the Nachhilfe-Mentor auto-blog.sh mechanics exactly, adapted for a
# different topic/brand and a temporary preview domain (no real posting).
#
# Usage:
#   ./robowire-blog.sh batch 10     Run 10 cycles back-to-back, no waiting, then exit.
#   ./robowire-blog.sh loop         Run forever with INTERVAL_SECONDS between cycles (for systemd).
#   ./robowire-blog.sh              Same as "loop", started in a tmux session (manual/dev use only).

set -euo pipefail

REPO_DIR="/home/opc/RoboWire-Blog"
LOG_FILE="$REPO_DIR/auto-blog.log"
INTERVAL_SECONDS=28800  # 8 hours, same cadence as production Nachhilfe-Mentor blog

# ─── The Prompt given to Claude Code ─────────────────────────────────────────

BLOG_PROMPT='You are the autonomous blog manager for RoboWire, an English-language robotics blog. Your working directory is /home/opc/RoboWire-Blog.

## PREVIEW BUILD - IMPORTANT
This site is NOT live yet. It is served from a temporary preview URL for internal review only.
- Do NOT attempt to submit anything to search engines, Pinterest, or any external indexing/social service.
- Do NOT run blog/_update_seo.py with --ping.
- Do NOT push to any git remote (there is none configured yet). A local commit is enough.

## Core principle
Optimize for genuinely useful, technically correct robotics content. Save context: you write the article and metadata, but you do NOT hand-edit the big structural files. The template, blog index, and registry are maintained by scripts.

## Anti-duplicate rules
- Read blog/_BLOG_CONTEXT_COMPACT.md first. Use this instead of blog/_BLOG_REGISTRY.md and blog/_BLOG_STRATEGY.md directly.
- Pick a topic that is not in "Slugs Already Used", "Recent Articles", or already covered in the Keyword Pool as done.
- Before writing, check: test ! -f blog/posts/<SLUG>.html
- Before publishing, run: python3 blog/_publish_article.py <SLUG> --check
- If the slug or title already exists, pick a different topic.

## Workflow

### 1. Context
- Read blog/_BLOG_CONTEXT_COMPACT.md.
- If there is a useful new insight worth keeping for future runs, add at most 3 short bullet points to blog/_BLOG_CONTEXT_NOTES.md. Otherwise do not touch it.

### 2. Choose a topic
- Pick one evergreen robotics keyword/topic from the strategy clusters (control systems & math, actuators & hardware, software & middleware, build guides, industry/career notes) that is not already covered.
- The article must fully answer a clear, specific search intent - avoid generic listicles.

### 3. Generate the cover image
- Run: bash blog/_generate-image.sh "<IMAGE_PROMPT>" "<SLUG>"
- Use the image-prompt style from blog/_BLOG_CONTEXT_COMPACT.md.
- No text in the image.

### 4. Write the article as JSON
Create ONLY this file: blog/articles/<SLUG>.json

Schema:
{
  "slug": "<ascii-slug>",
  "title": "<SEO title>",
  "h1_title": "<usually same as title>",
  "meta_description": "<max ~155 characters>",
  "keywords": ["keyword 1", "keyword 2", "keyword 3"],
  "tag": "<one of: Control Systems, Hardware, Software, Build Guides, Industry>",
  "subtitle": "<short hero subtitle>",
  "excerpt": "<short blog-index teaser>",
  "image_alt": "<natural alt text>",
  "image_prompt": "<image prompt used>",
  "content_html": "<article body only, as HTML, no nav, no footer, no CTA>",
  "registry_summary": "<detailed summary for the registry>",
  "internal_links": [
    {"source": "<SLUG>", "target": "<other-slug>", "note": "<why linked>"}
  ],
  "backlinks": [
    {"source": "<older-slug>", "target": "<SLUG>", "note": "backlink added in conclusion"}
  ]
}

Quality requirements for content_html:
- 800-1300 words.
- Clear, direct English, technically correct.
- Use h2, h3, p, ul, ol, blockquote sensibly.
- Focus keyword in the title, meta description, first H2, and 2-3 times naturally in the body.
- 1-2 internal links to other RoboWire articles if a natural connection exists.
- No CTA block, no navigation, no footer, no analytics code - the template adds those.
- No em dashes or en dashes.
- No fabricated statistics or fake citations.

### 5. Limited crosslinks
- You may read at most 3 relevant existing articles.
- If a natural spot exists, add a backlink to the new article there.
- Do not force a link if no natural spot exists.
- Record any links set in the JSON backlinks field.

### 6. Publish
- Run: python3 blog/_publish_article.py <SLUG>
- This creates blog/posts/<SLUG>.html from blog/_template.html.
- This updates blog/index.html and blog/_BLOG_REGISTRY.md.
- If it aborts due to a duplicate, pick a new topic.

### 7. Git commit (local only, no push)
- git add all changed and new files except auto-blog.log
- git commit with a descriptive English message.
- No Co-Authored-By tag, no AI signature.
- Do NOT push. There is no remote configured for this preview build.

## What you must NOT do
- Do not hand-edit blog/index.html.
- Do not read or copy blog/_template.html.
- Do not read the full blog/_BLOG_REGISTRY.md unless a script error cannot be debugged without it.
- Do not read all existing articles.
- Do not run blog/_update_seo.py with --ping.
- Do not post to Pinterest or any other external service.
- Do not push to git.

## Completion protocol
End every run with:

RUN COMPLETE:
[ ] Article JSON written: blog/articles/<SLUG>.json
[ ] Cover image generated: blog/posts/img/<SLUG>.webp
[ ] Publish script run: python3 blog/_publish_article.py <SLUG>
[ ] Crosslinks set: yes/no (where)
[ ] Git commit: done (local only, no push)

Start now with step 1.'

# ─── Main Loop ───────────────────────────────────────────────────────────────

run_blog_cycle() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] Starting blog cycle..." | tee -a "$LOG_FILE"

    cd "$REPO_DIR"

    # Build a compact context snapshot so Claude does not need to read the
    # full registry and strategy on every cycle.
    python3 blog/_prepare_blog_context.py 2>&1 | tee -a "$LOG_FILE"

    # Run Claude Code with the blog prompt
    claude --dangerously-skip-permissions -p "$BLOG_PROMPT" 2>&1 | tee -a "$LOG_FILE"

    local exit_code=$?
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    if [ $exit_code -eq 0 ]; then
        echo "[$timestamp] Blog cycle completed successfully." | tee -a "$LOG_FILE"
    else
        echo "[$timestamp] Blog cycle failed with exit code $exit_code." | tee -a "$LOG_FILE"
    fi

    # Commit fallback: commit any Blog Agent output Claude forgot to commit.
    cd "$REPO_DIR"
    git add blog/ 2>/dev/null || true
    if ! git diff --cached --quiet; then
        git commit -m "chore: blog agent output (supervisor commit fallback)" 2>&1 | tee -a "$LOG_FILE"
        echo "[$timestamp] Supervisor committed leftover Blog Agent changes." | tee -a "$LOG_FILE"
    fi

    # SEO safety fallback: regenerate sitemap.xml + feed.xml. Never pings
    # external services in this preview build (no --ping flag).
    echo "[$timestamp] Running SEO safety fallback (sitemap + feed only, no ping)..." | tee -a "$LOG_FILE"
    cd "$REPO_DIR"
    python3 blog/_update_seo.py 2>&1 | tee -a "$LOG_FILE"
    git add sitemap.xml feed.xml 2>/dev/null || true
    git diff --cached --quiet || git commit -m "chore: SEO safety update (sitemap + feed)" 2>&1 | tee -a "$LOG_FILE"

    echo "[$timestamp] Cycle finished." | tee -a "$LOG_FILE"
    echo "---" | tee -a "$LOG_FILE"
}

set +e

if [ "${1:-}" = "batch" ]; then
    COUNT="${2:-10}"
    echo "RoboWire batch run started at $(date) - $COUNT cycles, no waiting between them." | tee -a "$LOG_FILE"
    for i in $(seq 1 "$COUNT"); do
        echo "=== Batch cycle $i / $COUNT ===" | tee -a "$LOG_FILE"
        run_blog_cycle
    done
    echo "RoboWire batch run finished at $(date)." | tee -a "$LOG_FILE"
    exit 0
fi

if [ "${1:-}" != "loop" ]; then
    echo "Starting RoboWire auto-blog tmux session..."
    tmux kill-session -t robowire-blog 2>/dev/null || true
    tmux new-session -d -s robowire-blog "$0 loop"
    echo "tmux session 'robowire-blog' started."
    echo "  - Watch:  tmux attach -t robowire-blog"
    echo "  - Stop:   tmux kill-session -t robowire-blog"
    echo "  - Logs:   tail -f $LOG_FILE"
    exit 0
fi

# Loop mode (intended to run under systemd, same pattern as autoblog.service)
echo "RoboWire auto-blog loop started at $(date)" | tee -a "$LOG_FILE"
echo "Interval: ${INTERVAL_SECONDS}s ($((INTERVAL_SECONDS/3600))h)" | tee -a "$LOG_FILE"

WAKE_SIGNAL="/tmp/robowire-blog-wake"

_interruptible_sleep() {
    local remaining=$1
    while [ "$remaining" -gt 0 ]; do
        if [ -f "$WAKE_SIGNAL" ]; then
            rm -f "$WAKE_SIGNAL"
            echo "$(date) Wake signal received - starting cycle early" | tee -a "$LOG_FILE"
            return
        fi
        sleep 30
        remaining=$((remaining - 30))
    done
}

while true; do
    run_blog_cycle
    echo "$(date) Next cycle in $((INTERVAL_SECONDS/3600))h - touch $WAKE_SIGNAL to run early" | tee -a "$LOG_FILE"
    _interruptible_sleep "$INTERVAL_SECONDS"
done
