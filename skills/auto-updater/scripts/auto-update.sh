#!/bin/bash
# Auto-update script for Iris skills
# Runs daily via cron

LOG="/tmp/auto-update.log"
echo "=== Auto-Update: $(date) ===" >> "$LOG"

# Update clawhub itself
npm install -g clawhub 2>&1 | tail -3 >> "$LOG"

# Update all skills
clawhub update --all 2>&1 >> "$LOG"

echo "Done at $(date)" >> "$LOG"
