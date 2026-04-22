#!/bin/bash
# AI News Digest - Iris Free Selection Mode
# No strict item limit, collect what seems interesting
# Iris will pick and comment when delivering

SKILL_DIR="/root/.openclaw/workspace/skills/rss-reader"
OUTPUT_FILE="/root/.openclaw/workspace/ai-news-today.md"
MAX_PER_SOURCE=8

cd "$SKILL_DIR"

# Fetch all feeds
node scripts/rss.js check --category ai 2>/dev/null | grep "^\[ai\]" > /tmp/feed-llama.txt
node scripts/rss.js check --category reddit 2>/dev/null > /tmp/feed-reddit.txt
node scripts/rss.js check --category hn 2>/dev/null | grep "^\[tech\]" > /tmp/feed-hn.txt
node scripts/rss.js check --category arxiv 2>/dev/null | grep "^\[arxiv\]" > /tmp/feed-arxiv.txt

# Build the raw content file (Iris will read and select)
cat > "$OUTPUT_FILE" << HEADER
# AI 前沿动态 - $(date '+%Y-%m-%d')

HEADER

# Helper to parse titles
parse_title() {
  echo "$1" | sed 's/^\[[^]]*\] [^:]*: "//' | sed 's/" *([0-9]*/\n/' | head -n1
}

# LocalLLaMA
if [ -s /tmp/feed-llama.txt ]; then
  echo "## LocalLLaMA" >> "$OUTPUT_FILE"
  count=0
  while IFS= read -r line && [ $count -lt $MAX_PER_SOURCE ]; do
    title=$(parse_title "$line")
    [ -n "$title" ] && echo "TITLE: $title" >> "$OUTPUT_FILE" && ((count++))
  done < /tmp/feed-llama.txt
  echo "" >> "$OUTPUT_FILE"
fi

# Reddit feeds
if [ -s /tmp/feed-reddit.txt ]; then
  echo "## Reddit" >> "$OUTPUT_FILE"
  count=0
  while IFS= read -r line && [ $count -lt $MAX_PER_SOURCE ]; do
    title=$(parse_title "$line")
    source=$(echo "$line" | sed 's/^\[reddit\] \([^:]*\):.*/\1/')
    [ -n "$title" ] && echo "[$source] TITLE: $title" >> "$OUTPUT_FILE" && ((count++))
  done < /tmp/feed-reddit.txt
  echo "" >> "$OUTPUT_FILE"
fi

# Hacker News
if [ -s /tmp/feed-hn.txt ]; then
  echo "## Hacker News" >> "$OUTPUT_FILE"
  count=0
  while IFS= read -r line && [ $count -lt $MAX_PER_SOURCE ]; do
    title=$(parse_title "$line")
    [ -n "$title" ] && echo "TITLE: $title" >> "$OUTPUT_FILE" && ((count++))
  done < /tmp/feed-hn.txt
  echo "" >> "$OUTPUT_FILE"
fi

# arXiv
if [ -s /tmp/feed-arxiv.txt ]; then
  echo "## arXiv" >> "$OUTPUT_FILE"
  count=0
  while IFS= read -r line && [ $count -lt $MAX_PER_SOURCE ]; do
    title=$(parse_title "$line")
    [ -n "$title" ] && echo "TITLE: $title" >> "$OUTPUT_FILE" && ((count++))
  done < /tmp/feed-arxiv.txt
fi

echo "" >> "$OUTPUT_FILE"
echo "--raw collected at $(date)" >> "$OUTPUT_FILE"
