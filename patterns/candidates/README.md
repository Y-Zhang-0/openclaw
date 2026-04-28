# Patterns/candidates — 待验证的候选 Pattern

> 新发现的 Pattern，需要 1-2 次验证后才能移入核心 PATTERNS.md

---

# Candidate: same-second-multi-cron-trigger
- 场景：23:59 自检和 GitHub 备份同秒触发，session 启动排队
- 做法：合并为顺序执行的一个任务，或错开 1-2 秒
- 验证状态：待确认
- 发现日期：2026-04-25

---

# Candidate: isolated-session-cold-start-timeout
- 场景：isolated session 冷启动慢，LVM 冷启动 + 内容生成慢导致 timeout
- 做法：timeout 设为 300s；轻量任务可解决
- 验证状态：待确认
- 发现日期：2026-04-26

---

# Candidate: cron-schedule-immediate-verify
- 场景：本意每日 23:59 执行，实际每分钟触发（cron 表达式写错）
- 做法：创建 cron 后立即查 `openclaw cron list` 确认 nextRunAtMs
- 验证状态：待确认
- 发现日期：2026-04-24

---

_最后更新：2026-04-28_
