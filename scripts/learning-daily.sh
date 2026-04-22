#!/bin/bash
# Daily Learning Content Pusher
# Runs at 20:00 every day
# Sends today's learning topic + resources to user

PLAN_FILE="$HOME/study/learning-plan-v2/daily-schedule.md"
PROGRESS_FILE="$HOME/.openclaw/workspace/learning-progress.md"
OUTPUT_FILE="/tmp/learning-today.md"

# Get current day number (since plan started 2026-04-06)
START_DATE="2026-04-06"
TODAY=$(date +%Y-%m-%d)

# Calculate days since start
DAYS_SINCE_START=$((($(date +%s) - $(date -d "$START_DATE" +%s)) / 86400))

# Current day in the plan
CURRENT_DAY=$((DAYS_SINCE_START + 1))

# Check progress file to see where user actually is
LAST_COMPLETED=$(grep -E "^\| D[0-9]+" "$PROGRESS_FILE" 2>/dev/null | tail -1 | awk -F'|' '{print $3}' | tr -d ' ')

echo "Today is day $CURRENT_DAY in the plan"
echo "Last completed: $LAST_COMPLETED"
