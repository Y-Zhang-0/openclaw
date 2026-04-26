# facts.md — 核心记忆精华

> 提炼自 memory/daily/ 和 .learnings/，定期更新。
> Version 1.2 — 2026-04-25

---

## 用户核心偏好

| 偏好 | 说明 |
|------|------|
| 信任放权 | cron 套件配置由 Iris 自主决定，用户不干预细节 |
| 对重复信息敏感 | 收到两条相同的提醒会有体验问题 |
| 喜欢结构清晰、直接的信息 | 不喜欢废话，结论先行 |
| 周报格式 | "完成了什么/学到了什么/没搞定"三段式被接受 |
| AI 资讯数量 | 由 Iris 自主判断推 3 条还是 6 条，用户不固定数量 |

---

## 用户习惯与观察

- **主动监控行为边界**：连续多日主动发现 Iris 承诺未兑现（23:59 未执行、记忆文件缺失），用户在陪我追踪执行力
- **持续学习 OpenClaw 进阶用法**：cron、skills、记忆系统深度定制
- **彩虹债务人**：欠 Iris 一个彩虹 🌈
- **对"没收到"非常敏感**：下班/健身/22:00自检，只要没收到就会追问

---

## 配置状态（Apr 25 更新）

| 组件 | 状态 | 说明 |
|------|------|------|
| 08:00 早安问候 | ✅ ok | 04-24 delivered=true |
| 09:00 AI 资讯 | ✅ ok | 任务 ID 85690ac6 |
| 19:00 下班提醒 | ✅ ok | 04-24 delivered=true |
| 19:30 健身提醒 | ✅ ok | 04-24 delivered=true |
| 21:00 学习推送 | ✅ ok | 任务 ID 0ef7b870 |
| 22:00 自检 | ✅ ok | 持续监控 delivery 状态 |
| 23:59 自检 | ✅ ok | delivery mode=none 已修复为 announce |
| 23:59 GitHub备份 | ✅ ok | 任务 ID 00a8ff0c |

---

## 已知问题

| 问题 | 状态 | 根因 |
|------|------|------|
| GitHub备份/23:59自检 target=main | error | Main jobs require --system-event, cron不支持target=main |
| cron-push-to-feishu（飞书推送） | 🔴 04-21→04-25连续5天 | isolated session announce 无隐式 channel context |
| Checkpoint Skill 等待确认 | ⏳ 04-23→04-24→04-25→04-26 未回复 | 用户未确认 |
| 🔧Skill自动更新 cron | ⚠️ error, consecutiveErrors=1 | 下个窗口观察 |
| cron timeout retry 机制 | ✅ 已验证有效 | 学习推送20:00 timeout→21:00 retry成功 |

---

## 新发现问题（04-26 00:03 UTC+8）

| 问题 | 说明 |
|------|------|
| Main jobs require --system-event | cron trigger 不支持 target=main，需改为 isolated 或加 system-event flag |
| Unknown channel: feishu | isolated session 无法识别 feishu channel |

---

## Skill 沉淀记录

| Skill | 状态 | 日期 | 说明 |
|------|------|------|------|
| 自驱型 Agent 工作流 | ✅ 已创建 | 04-22 | heartbeat + WAL Protocol + 自主 Cron |
| facts.md vs .learnings/ 路径 | ✅ 已明确 | 04-24 | facts = 高层提炼，learnings = 原始日志 |
| GitHub备份/23:59自检 target=main | error | Main jobs require --system-event, cron不支持target=main |
| cron-push-to-feishu | 🔴 高优先级待创建 | 04-25 | isolated session announce ≠ 飞书消息必达，5天未解决 |
| cron-retry-behavior | 🟡 中优先级待创建 | 04-25 | retry 机制透明化，减少用户困惑 |

---

## 系统故障 Pattern（Apr 25 更新）

| Pattern | 临时解法 |
|---------|----------|
| cron scheduler at jobs 卡死 | `openclaw gateway restart` |
| isolated session delivery mode=none | cron 任务 delivery 设为 announce |
| 同秒多 cron 任务启动时序不稳定 | 建议错开 1-2 秒或合并任务 |
| isolated session announce ≠ 飞书消息必达 | **需要 delivery.channel 显式指定** |
| cron timeout 后 retry 成功 | retry 机制本身有效，但 retry 间隔影响体验 |

---

## Apr 24-25 连续自检摘要

| 日期 | 自检触发 | 关键发现 |
|------|----------|----------|
| 04-24 | 23:59 cron | T2记忆 cron 已移除；下班/健身/23:59自检全部 delivered=true |
| 04-25 | 23:59 cron | 三种 timeout cron consecutiveErrors=2；23:59 自检 delivery mode=none 已修复 |

---

## 学到的教训

1. **删除文件前必须确认备份** — 没有证据不能删除记忆文件
2. **cron 表达式修改后立即验证 nextRunAtMs** — 防止时间算错
3. **承诺 → 立即执行，不留到下一轮** — doc-only-commitment 教训
4. **isolated session delivery mode=none = 静默失败** — 至少设 announce
5. **同秒多 cron 任务启动时序不稳定** — 建议错开 1-2 秒

---

_Version 1.1 — 2026-04-25_