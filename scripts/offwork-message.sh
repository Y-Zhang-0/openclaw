#!/bin/bash
MESSAGE="🌙 差不多该下班了。

今天辛苦了，
站起来动一动，
喝杯水，
或者就发会儿呆。

工作永远做不完，
但你只有一个。
早点休息。"

echo "$MESSAGE" >> /tmp/offwork-message.txt
echo "Sent at $(date)" >> /tmp/offwork-cron.log
