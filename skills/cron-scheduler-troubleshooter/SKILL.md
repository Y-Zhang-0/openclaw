---
name: Cron-Scheduler-Troubleshooter
slug: cron-scheduler-troubleshooter
version: 1.0.0
description: "解决 cron scheduler at jobs 卡死、nextWakeAtMs 不更新、任务不触发的问题"
metadata: {"version":"1.0.0","author":"Iris","purpose":"cron-scheduler-debug"}
---

# Cron-Scheduler-Troubleshooter

> 处理 cron scheduler 卡死、at jobs 不触发、nextWakeAtMs 不更新的问题

## Pattern: cron-scheduler-at-stuck

| 字段 | 内容 |
|------|------|
| **场景** | cron scheduler at jobs 卡死，nextWakeAtMs 不更新，任务不触发 |
| **做法** | `openclaw gateway restart` 临时解决；关注 GitHub issue 跟踪 |
| **置信度** | 高（已出现 3+ 次） |
| **使用次数** | 持续累计 |
| **上次使用** | 2026-04-26 |

## 症状识别

1. `openclaw cron list` 显示任务下次执行时间已过但仍未触发
2. cron run 日志显示任务状态为 running 但长时间无响应
3. gateway 日志出现 "scheduler tick" 但没有实际任务触发

## 诊断步骤

```bash
# 1. 检查 gateway 状态
openclaw gateway status

# 2. 查看 scheduler tick 日志
tail -50 /root/.openclaw/logs/gateway.log | grep -E "scheduler|at job|nextWakeAtMs"

# 3. 检查 cron list 当前状态
openclaw cron list

# 4. 重启 gateway
openclaw gateway restart
# 或完整重启（更彻底）：
systemctl --user restart openclaw
```

## 临时解决

```bash
# 推荐顺序：
1. openclaw gateway restart  # 快速重启（仅重启进程）
2. systemctl --user restart openclaw  # 如果1无效，用完整重启
```

## 注意事项

- `openclaw gateway restart` 只重启进程，不重建 session 连接
- 重启后 session 需要外部消息（@）才能唤醒
- 不要在用户活跃时随意重启 gateway

## 关联 Pattern

- **Pattern-gateway-watchdog**：每小时检查 gateway 状态，挂了用 systemctl restart
- **Pattern-session-needs-external-trigger**：gateway 重启后 session 需要 @ 才能唤醒
