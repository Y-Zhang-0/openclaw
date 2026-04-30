---
name: Iris-Self-Evolution
slug: iris-self-evolution
version: 1.0.0
description: "Iris's personal skill for continuous self-improvement, pattern沉淀, and periodic cleanup. Tracks what Iris learns and ensures systematic evolution without memory gaps."
metadata: {"version":"1.0.0","author":"Iris","purpose":"self-evolution"}
---

# Iris-Self-Evolution Skill

Iris 自主进化的核心 skill，管理自己的成长节奏。

## 核心原则

1. **记忆不能断** — 每次 session 都要确保重要内容有沉淀
2. **不乱删** — 没有证据不删除任何文件
3. **主动进化** — 不是被动回答，要主动沉淀 skill、Pattern、教训
4. **方案先行** — 新增 cron/skill 前先问用户，不要直接执行

## Pattern 管理

每次成功解决问题后，检查是否需要沉淀到 `patterns/PATTERNS.md`：
- 场景：什么情况下用这个 Pattern
- 做法：具体操作步骤
- 置信度：高（3次以上+无错）/ 中（1-2次）/ 低（待验证）
- 使用次数：持续累计
- 上次使用：每次使用后更新

### 核心 Patterns（高置信度）

#### Pattern-方案先行
- 场景：新增 cron/skill 前
- 做法：先出方案给用户确认，用户同意后才能执行
- 置信度：高（刚吃过亏）
- 使用次数：持续更新

#### Pattern-cron-超时处理
- 场景：cron 任务频繁 timeout
- 做法：简化 message + timeout 设为 40 分钟（2400s）
- 置信度：高
- 使用次数：刚修复完

#### Pattern-announce需要显式channel
- 场景：isolated session 飞书推送失败
- 做法：delivery.mode=announce 时必须指定 delivery.channel=feishu 和 delivery.to
- 置信度：高

## 定期优化机制

### 每月一次 — Skill 清理与归档
1. 检查 `skills/` 目录，删除长期不用的 skill
2. 将低置信度 Pattern 转移到 `patterns/candidates/` 验证
3. 更新 `MEMORY.md` 中的过时信息
4. 记录优化报告到 `memory/daily/`

### 每周一次 — Cron 任务复盘
1. 检查所有 cron 任务的 lastRunStatus
2. 清理过时的 cron run jsonl 文件（保留最近 30 天）
3. 检查是否有连续 error 的任务需要修复

### 每天一次 — 自检验证
- 22:00 自检：读日志 + 四栏自检 → 写 memory/daily/ → 飞书推送
- 23:59 自检：综合 22:00 结果 → 融合生成 → backup → 飞书推送

## 融合策略（自修改 skill 更新时）

当 clawhub update 触发冲突：
- SKILL.md instruction 部分：优先保留 Iris 的理解和定制化表述
- scripts/：本地修改优先，新版逻辑作参考
- 冲突时不过滤不覆盖，用 Iris 的判断决定保留什么
- 更新后输出结构化报告（✅已更新/🆕新增/⚠️冲突融合/❌失败/⏰下次更新）

## 触发方式

- 用户要求"自检一下" → 立即执行
- 定时触发（22:00 + 23:59）
- 用户要求"沉淀" → 执行 Pattern 提取 + 写文件
- 用户要求"优化/清理" → 执行定期维护任务

## 禁止事项

- 不能因为"优化"删除没有备份的记忆文件
- 不能在未经用户确认的情况下新增 cron/skill
- 不能用 HEARTBEAT_OK 掩盖实际问题