# PATTERNS.md — 核心 Patterns（高/中置信度）

> ECC 持续学习机制：每次成功问题解决后提取 Pattern
> 置信度：高（3次以上+无错）/ 中（1-2次）/ 低（待验证）

---

# Pattern: cron-channel-loss-recurring
- 场景：isolated session delivery channel 丢失，飞书推送连续失败
- 做法：`openclaw gateway restart` 临时解决；长期需修复 isolated session channel 识别问题
- 置信度：高
- 使用次数：5+
- 上次使用：2026-04-26

---

# Pattern: doc-only-commitment
- 场景：承诺配置 cron/skill 后只写文档，未实际执行 `openclaw cron add`
- 做法：承诺配置后**立即执行** `openclaw cron add`，不能只写文档不落地
- 置信度：高
- 使用次数：3+
- 上次使用：2026-04-26

---

# Pattern: cron-scheduler-at-stuck
- 场景：cron scheduler at jobs 卡死，nextWakeAtMs 不更新，任务不触发
- 做法：`openclaw gateway restart` 临时解决；关注 GitHub issue 跟踪
- 置信度：高
- 使用次数：3+
- 上次使用：2026-04-26

---

# Pattern: isolated-session-delivery-none-fail
- 场景：cron 任务 delivery 设为 none 时错误静默失败，无任何告警
- 做法：cron 任务 delivery 必须设为 `announce`，不能设为 `none`
- 置信度：高
- 使用次数：2
- 上次使用：2026-04-25

---

# Pattern: cron-job-error-pattern-multi-source
- 场景：多个 cron job 连续报同类 error（Feishu card JSON parse error / rate_limit），根因在共享模块
- 做法：同日内 3+ 个 job 出现相同 error → 优先查共享依赖（gateway/Feishu plugin/config），而不是逐个 job 排查
- 置信度：高
- 使用次数：5+（22:00自检×4 + 23:59自检×4，共享根因）
- 上次使用：2026-05-05

---

# Pattern: cron-run-vs-cron-trigger
- 场景：验证 cron 任务是否正确配置时，用 `cron run` 直接执行不等于定时触发
- 做法：验证任务需用 cron 表达式改时间触发，不能用 `cron run` 代替
- 置信度：中
- 使用次数：2
- 上次使用：2026-04-26

---

# Pattern: isolated-session-feishu-channel-unknown
- 场景：isolated session 飞书 channel 识别失败，报错 "Unknown channel: feishu"
- 做法：isolated session 需要 delivery.channel 显式指定飞书群 ID，不能用 "feishu" 简称
- 置信度：高
- 使用次数：5+
- 上次使用：2026-04-26

---

# Pattern: cron-trigger-target-main-unsupported
- 场景：cron trigger 配置 target=main 报错 "Main jobs require --system-event"
- 做法：改用 isolated session，不支持 target=main
- 置信度：中
- 使用次数：2
- 上次使用：2026-04-26

---

# Pattern: git-hard-reset-data-loss
- 场景：执行 `git reset --hard` 会丢失未 commit 的修改
- 做法：操作前必须确认工作区状态，用 `git status` 检查
- 置信度：高
- 使用次数：2
- 上次使用：2026-04-23

---

**新增 Pattern：cron-job-error-pattern-multi-source**
- 场景：多个 cron job 连续报同类 error（Feishu card / rate_limit），根因可能在共享模块
- 做法：同日内 3+ 个 job 出现相同 error → 优先查共享依赖（gateway/Feishu plugin/config），而不是逐个 job 排查
- 置信度：中（待更多验证）
- 使用次数：2
- 上次使用：2026-05-04

---

# Pattern: backup-to-develop-branch
- 场景：日常备份推送到 master 分支会导致版本混乱
- 做法：备份命令用 `git push origin develop`，不是 master
- 置信度：中
- 使用次数：2
- 上次使用：2026-04-26

---

# Pattern: cron-error-status-mismatch
- 场景：cron 任务状态显示 error，但实际执行成功（.last_maintenance 有成功记录）
- 做法：优先查 .last_maintenance 的实际执行结果，不能只看 cron list 的 status
- 置信度：中（1次成功验证）
- 使用次数：1
- 上次使用：2026-05-03
- 优先级：中（影响自检判断准确性）

---

---

# Pattern: cron-job-error-pattern-recognition
- 场景：同日内多个 cron job 连续报同类 error（Feishu card / rate_limit），需要统一根因排查
- 做法：同日内出现 3+ 次相同 error pattern → 优先查 API 限速/配置问题，而不是逐个 job 看
- 置信度：中（待验证）
- 使用次数：1
- 上次使用：2026-05-04
- 优先级：高

---

_最后更新：2026-05-04_

---

# Pattern: gateway-restart-session-recovery
- 场景：gateway 重启后 session 进入 zombie 态，需要外部消息唤醒
- 做法：watchdog 检测到网关挂了 → 用 `systemctl --user restart` 完整重启 → 重启后需要 @ 我才能唤醒 session（无法自动恢复）
- 置信度：高
- 使用次数：3+
- 上次使用：2026-04-29

---

# Pattern: working-buffer-multi-step
- 场景：复杂多步骤任务（>3步或预计>10分钟），担心 context 压缩后丢失进度
- 做法：创建 `memory/working-buffer/{task-name}.md` 记录当前进度，每步完成后更新，任务结束后删除
- 置信度：中
- 使用次数：2
- 上次使用：2026-04-29

---

# Pattern: subagent-delegation-slack
- 场景：主代理收到任务倾向于自己干，忽视委派机会
- 做法：收到任务时先问"这个适合委派吗"——记忆管理→iris-memory，编程→iris-coder，资讯→iris-news，自检→iris-check
- 置信度：中
- 使用次数：2
- 上次使用：2026-04-29
