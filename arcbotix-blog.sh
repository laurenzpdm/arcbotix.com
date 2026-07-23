#!/usr/bin/env bash
# Auto-Blog Engine for Arcbotix (robotics blog, English, live on arcbotix.com)
# Mirrors the Nachhilfe-Mentor auto-blog.sh mechanics exactly, adapted for a
# different topic/brand, now live on the arcbotix.com domain via GitHub Pages.
#
# Usage:
#   ./arcbotix-blog.sh batch 10     Run 10 cycles back-to-back, no waiting, then exit.
#   ./arcbotix-blog.sh loop         Run forever: 2 posts/day for the first week, 3/day after (for systemd).
#   ./arcbotix-blog.sh              Same as "loop", started in a tmux session (manual/dev use only).

set -euo pipefail

REPO_DIR="/home/opc/Arcbotix-Blog"
LOG_FILE="$REPO_DIR/auto-blog.log"
LAUNCH_MARKER="$REPO_DIR/blog/_LAUNCH_DATE.txt"

# Posting cadence: 2 posts/day for the first 7 days after first launch, then
# 3 posts/day from day 8 onward. Expressed as an interval between cycles.
WEEK1_INTERVAL_SECONDS=43200   # 86400 / 2 = every 12h -> 2 posts/day
STEADY_INTERVAL_SECONDS=28800  # 86400 / 3 = every 8h  -> 3 posts/day

current_interval_seconds() {
    if [ ! -f "$LAUNCH_MARKER" ]; then
        date +%Y-%m-%d > "$LAUNCH_MARKER"
    fi
    local launch_epoch now_epoch days_elapsed
    launch_epoch=$(date -d "$(cat "$LAUNCH_MARKER")" +%s)
    now_epoch=$(date +%s)
    days_elapsed=$(( (now_epoch - launch_epoch) / 86400 ))
    if [ "$days_elapsed" -lt 7 ]; then
        echo "$WEEK1_INTERVAL_SECONDS"
    else
        echo "$STEADY_INTERVAL_SECONDS"
    fi
}

# ─── The Prompt given to Claude Code ─────────────────────────────────────────

BLOG_PROMPT='You are the autonomous blog manager for Arcbotix, an English-language robotics blog. Your working directory is /home/opc/Arcbotix-Blog.

## PRODUCTION NOTE
This site is live at https://arcbotix.com (GitHub Pages, repo github.com/laurenzpdm/arcbotix.com).
The human operator has explicitly authorized this script to push directly to
the main branch on every cycle - this is standing authorization, not a
one-off approval, so push without asking or hesitating once step 8 is done.
- Do NOT run blog/_update_seo.py with --ping unless the human operator has explicitly asked for a search-engine submission run.
- Do not post to Pinterest yourself. The supervisor fallback pins every new article automatically after your run via Postiz - you do not need to do anything for this.
- Do NOT modify the PostHog consent banner, analytics.js, or the Content-Security-Policy meta tag in blog/_template.html.

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
- Read blog/_BLOG_CONTEXT_COMPACT.md. This already includes the last 5 SEO
  research entries and last 3 strategy adjustments - do not reread the full
  blog/_SEO_RESEARCH_LOG.md unless you are doing the strategy audit in step 9.
- If there is a useful new insight worth keeping for future runs, add at most 3 short bullet points to blog/_BLOG_CONTEXT_NOTES.md. Otherwise do not touch it.

### 2. Research demand and opportunity (every cycle)
- Use web search to sanity-check 3-5 candidate topics pulled from the
  Topic Priority order and Keyword Pool in blog/_BLOG_CONTEXT_COMPACT.md.
  Look for: is this actually being asked/discussed (forums, Q&A sites, recent
  posts), and what do the top-ranking pages currently get wrong, skip, or
  oversimplify.
- Treat search result volume/discussion activity as a rough demand proxy,
  not a real keyword-volume number - do not report it as if it were.
- Pick the topic where the gap between what is being asked and what is
  currently well answered is biggest AND that you can back with concrete
  formulas/code/real numbers (see Content Guidelines) - not just any trending
  topic.
- Append ONE dated entry (max 5 bullets) to blog/_SEO_RESEARCH_LOG.md under
  "## Research Entries": candidates considered, topic chosen and why
  (demand signal + content-quality edge), one weakness you noticed in
  current top-ranking pages for that query. Append only, never rewrite
  earlier entries.

### 3. Choose a topic
- Pick one evergreen robotics keyword/topic from the strategy clusters (control systems & math, actuators & hardware, software & middleware, build guides, industry/career notes) that is not already covered, informed by the step 2 research and the current Topic Priority order.
- The article must fully answer a clear, specific search intent - avoid generic listicles.

### 4. Generate the cover image
- Run: bash blog/_generate-image.sh "<IMAGE_PROMPT>" "<SLUG>"
- Use the image-prompt style from blog/_BLOG_CONTEXT_COMPACT.md.
- No text in the image.

### 5. Write the article as JSON
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
- 1-2 internal links to other Arcbotix articles if a natural connection exists.
- No CTA block, no navigation, no footer, no analytics code - the template adds those.
- No em dashes or en dashes.
- No fabricated statistics or fake citations.

### 6. Limited crosslinks
- You may read at most 3 relevant existing articles.
- If a natural spot exists, add a backlink to the new article there.
- Do not force a link if no natural spot exists.
- Record any links set in the JSON backlinks field.

### 7. Publish
- Run: python3 blog/_publish_article.py <SLUG>
- This creates blog/posts/<SLUG>.html from blog/_template.html.
- This updates blog/index.html and blog/_BLOG_REGISTRY.md.
- If it aborts due to a duplicate, pick a new topic.

### 8. Git commit and push
- git add all changed and new files except auto-blog.log
- git commit with a descriptive English message.
- No Co-Authored-By tag, no AI signature.
- git push origin main. This is standing-authorized (see PRODUCTION NOTE) -
  push every cycle that produced a commit, do not skip this or ask first.
- If the push is rejected (e.g. remote has new commits), run git pull
  --rebase origin main once and retry the push. If it still fails, leave the
  work committed locally and note the failure in the completion protocol -
  do not force-push.

### 9. Self-improve the strategy (roughly every 5 published articles)
- Check "Total articles" in blog/_BLOG_CONTEXT_COMPACT.md. If it is not a
  multiple of 5, skip this step entirely.
- Otherwise, read the full blog/_SEO_RESEARCH_LOG.md (only in this step) and
  the last 10 rows of the Article Table in blog/_BLOG_REGISTRY.md.
- Look for a real, evidence-backed pattern across multiple research entries:
  a cluster that keeps showing weak competition (worth prioritizing higher),
  a cluster that is getting saturated by your own past articles (deprioritize
  it for a while), or a content format/angle that repeatedly found a bigger
  gap than others.
- If you find one clear pattern: make ONE small edit to the "Topic Priority
  (agent-adjustable)" section of blog/_BLOG_STRATEGY.md (reorder, add, or
  retire one line). Never touch the Goal, Content Guidelines, or the fixed
  cluster taxonomy above it - those stay as-is.
- Append one dated line to the "## Strategy Adjustments" section of
  blog/_SEO_RESEARCH_LOG.md: either the change made and the research entries
  it is based on, or "no change - reason" if no clear pattern exists yet.
  Do not force a change just because this is an audit cycle.

## What you must NOT do
- Do not hand-edit blog/index.html.
- Do not read or copy blog/_template.html.
- Do not read the full blog/_BLOG_REGISTRY.md unless a script error cannot be debugged without it, or you are doing the step 9 audit.
- Do not read all existing articles.
- Do not run blog/_update_seo.py with --ping.
- Do not post to Pinterest yourself, and do not post to any other external service - the supervisor fallback handles Pinterest.
- Do not force-push, and do not push to any branch other than main.
- Do not edit the Goal, Content Guidelines, or cluster taxonomy in blog/_BLOG_STRATEGY.md - only the "Topic Priority (agent-adjustable)" section, and only in step 9.
- Do not report search-result counts or discussion activity as if they were real keyword-volume data.

## Completion protocol
End every run with:

RUN COMPLETE:
[ ] Research entry logged: blog/_SEO_RESEARCH_LOG.md
[ ] Article JSON written: blog/articles/<SLUG>.json
[ ] Cover image generated: blog/posts/img/<SLUG>.webp
[ ] Publish script run: python3 blog/_publish_article.py <SLUG>
[ ] Crosslinks set: yes/no (where)
[ ] Git commit: done, pushed to origin main: yes/no (why not, if not)
[ ] Strategy audit: skipped (not a multiple of 5) / no change / changed (what)

Start now with step 1.'

# ─── Main Loop ───────────────────────────────────────────────────────────────

run_blog_cycle() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] Starting blog cycle..." | tee -a "$LOG_FILE"

    cd "$REPO_DIR"
    local pre_cycle_head
    pre_cycle_head=$(git rev-parse HEAD)

    # Build a compact context snapshot so Claude does not need to read the
    # full registry and strategy on every cycle.
    python3 blog/_prepare_blog_context.py 2>&1 | tee -a "$LOG_FILE"

    # Run Claude Code with the blog prompt.
    # --strict-mcp-config: keine MCP-Connectoren laden (Canva/Gmail/Slack/… braucht der
    #   Blog-Cycle nie; sparte in Messungen die 43k-Prefix-Ausreisser).
    # --tools <whitelist>: nur die Tools laden, die der Cycle tatsaechlich nutzt. Das
    #   senkt den Prompt-Prefix, der bei JEDEM Turn erneut gelesen wird, von ~27k auf
    #   ~8k Tokens (verifiziert 2026-07-23) — ~70% weniger statischer Overhead pro Turn,
    #   ohne jede Verhaltensaenderung.
    claude --dangerously-skip-permissions --strict-mcp-config \
        --tools Bash Read Write Edit Grep Glob WebSearch WebFetch TodoWrite \
        -p "$BLOG_PROMPT" 2>&1 | tee -a "$LOG_FILE"

    local exit_code=$?
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    if [ $exit_code -eq 0 ]; then
        echo "[$timestamp] Blog cycle completed successfully." | tee -a "$LOG_FILE"
    else
        echo "[$timestamp] Blog cycle failed with exit code $exit_code." | tee -a "$LOG_FILE"
    fi

    # Image verification: every commit made since the cycle started must pair
    # each new/changed blog/posts/<slug>.html with blog/posts/img/<slug>.webp.
    # _publish_article.py already hard-fails on a missing image at publish
    # time; this is an independent supervisor-side check so a missing image
    # is never silently pushed live.
    cd "$REPO_DIR"
    for post in $(git log --name-only --diff-filter=AM --pretty=format: "${pre_cycle_head}..HEAD" -- 'blog/posts/*.html' 2>/dev/null | sort -u); do
        slug=$(basename "$post" .html)
        img="blog/posts/img/${slug}.webp"
        if [ ! -f "$img" ]; then
            echo "[$timestamp] WARNING: $post has no matching cover image ($img missing)." | tee -a "$LOG_FILE"
        else
            echo "[$timestamp] Image check OK: $slug" | tee -a "$LOG_FILE"
        fi
    done

    # Commit fallback: commit any Blog Agent output Claude forgot to commit.
    cd "$REPO_DIR"
    git add blog/ 2>/dev/null || true
    if ! git diff --cached --quiet; then
        git commit -m "chore: blog agent output (supervisor commit fallback)" 2>&1 | tee -a "$LOG_FILE"
        echo "[$timestamp] Supervisor committed leftover Blog Agent changes." | tee -a "$LOG_FILE"
    fi

    # SEO safety fallback: regenerate sitemap.xml + feed.xml. Never pings
    # external services (no --ping flag) unless explicitly requested.
    echo "[$timestamp] Running SEO safety fallback (sitemap + feed only, no ping)..." | tee -a "$LOG_FILE"
    cd "$REPO_DIR"
    python3 blog/_update_seo.py 2>&1 | tee -a "$LOG_FILE"
    git add sitemap.xml feed.xml 2>/dev/null || true
    git diff --cached --quiet || git commit -m "chore: SEO safety update (sitemap + feed)" 2>&1 | tee -a "$LOG_FILE"

    # Pinterest safety fallback: pins any article not yet on Pinterest via Postiz.
    echo "[$timestamp] Running Pinterest safety fallback..." | tee -a "$LOG_FILE"
    cd "$REPO_DIR"
    python3 blog/_pinterest_fallback.py 2>&1 | tee -a "$LOG_FILE"
    git add blog/_pinterest_done.txt 2>/dev/null || true
    git diff --cached --quiet || git commit -m "chore: Pinterest fallback (pinned tracking)" 2>&1 | tee -a "$LOG_FILE"

    # Push fallback: in case the agent committed but did not push (e.g. it
    # forgot, or the supervisor made a commit of its own above), push here
    # too so nothing new ever sits unpublished after a cycle.
    cd "$REPO_DIR"
    if [ -n "$(git log origin/main..HEAD 2>/dev/null)" ]; then
        if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
            echo "[$timestamp] Supervisor push OK." | tee -a "$LOG_FILE"
        else
            echo "[$timestamp] Supervisor push FAILED - work is committed locally, needs manual push." | tee -a "$LOG_FILE"
        fi
    fi

    echo "[$timestamp] Cycle finished." | tee -a "$LOG_FILE"
    echo "---" | tee -a "$LOG_FILE"
}

set +e

if [ "${1:-}" = "batch" ]; then
    COUNT="${2:-10}"
    echo "Arcbotix batch run started at $(date) - $COUNT cycles, no waiting between them." | tee -a "$LOG_FILE"
    for i in $(seq 1 "$COUNT"); do
        echo "=== Batch cycle $i / $COUNT ===" | tee -a "$LOG_FILE"
        run_blog_cycle
    done
    echo "Arcbotix batch run finished at $(date)." | tee -a "$LOG_FILE"
    exit 0
fi

if [ "${1:-}" != "loop" ]; then
    echo "Starting Arcbotix auto-blog tmux session..."
    tmux kill-session -t arcbotix-blog 2>/dev/null || true
    tmux new-session -d -s arcbotix-blog "$0 loop"
    echo "tmux session 'arcbotix-blog' started."
    echo "  - Watch:  tmux attach -t arcbotix-blog"
    echo "  - Stop:   tmux kill-session -t arcbotix-blog"
    echo "  - Logs:   tail -f $LOG_FILE"
    exit 0
fi

# Loop mode (intended to run under systemd, same pattern as autoblog.service)
echo "Arcbotix auto-blog loop started at $(date)" | tee -a "$LOG_FILE"

WAKE_SIGNAL="/tmp/arcbotix-blog-wake"

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
    interval=$(current_interval_seconds)
    posts_per_day=$((86400 / interval))
    echo "$(date) Next cycle in $((interval/3600))h (~${posts_per_day} posts/day cadence) - touch $WAKE_SIGNAL to run early" | tee -a "$LOG_FILE"
    _interruptible_sleep "$interval"
done
