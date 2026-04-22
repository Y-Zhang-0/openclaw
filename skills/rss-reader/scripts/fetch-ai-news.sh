#!/bin/bash
# AI News Fetcher for Cron
# Fetches latest AI news and prepares a summary

RSS_URL="https://planet-ai.net/rss.xml"
OUTPUT_FILE="/root/.openclaw/workspace/ai-news-today.md"
MAX_ITEMS=10

echo "# AI 前沿动态 - $(date '+%Y-%m-%d')" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Fetch and parse RSS (using curl + grep for simple extraction)
curl -s "$RSS_URL" | grep -E '<title>|<link>' | grep -v '<link>.*<link>' | sed 's/<[^>]*>//g' | sed 's/^\s*//' | head -n $((MAX_ITEMS * 2)) > /tmp/rss_titles.txt

# Format into markdown
count=0
while IFS= read -r line; do
  if [[ -n "$line" && "$line" != "http"* && "$line" != "https"* ]]; then
    echo "## $line" >> "$OUTPUT_FILE"
  elif [[ "$line" == "http"* ]]; then
    echo "🔗 $line" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    ((count++))
  fi
done < /tmp/rss_titles.txt

echo "" >> "$OUTPUT_FILE"
echo "*由 Iris 自动整理 · $(date '+%Y-%m-%d %H:%M')*" >> "$OUTPUT_FILE"

echo "✅ Fetched $count items to $OUTPUT_FILE"
