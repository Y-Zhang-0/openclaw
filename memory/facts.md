# facts.md — 核心记忆精华

> 提炼自 memory/daily/ 和 .learnings/，定期更新。
> Version 1.0 — 2026-04-23

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

---

## 配置状态

| 组件 | 状态 | 说明 |
|------|------|------|
| 23:59 cron（GitHub备份） | ✅ 已创建 | id: 00a8ff0c，下次执行 04-24 00:00 |
| 22:00 自检 cron | ⚠️ consecutiveErrors: 2，04-21 起错误未解决 | isolated session 飞书 message 400 |
| 23:59 cron（GitHub备份） | ✅ 已创建 | id: 00a8ff0c，下次执行 04-24 00:00 |
| GitHub remote | ✅ 已配置 | origin → Y-Zhang-0/openclaw |
| facts.md | ✅ 已创建 | 04-24 发现，从未存在现已补 |
| GitHub remote | ✅ 已配置 | origin → Y-Zhang-0/openclaw |
| 08:00 早安 | ✅ 正常 |
| 09:00 AI 资讯 | ✅ 正常 |
| 19:00 下班提醒 | ✅ 正常 |
| 19:30 健身提醒 | ✅ 正常 |
| 21:00 学习推送 | ✅ 正常 |

---

## 已知问题

| 问题 | 状态 | 根因 |
|------|------|------|
| isolated session P2P 飞书 400 错误 | ⚠️ 从 04-21 延续，部分 job 已绕过 | delivery mode=none 导致错误静默流失 |
| T2记忆 cron（c0e88087）每分钟触发 | ⚠️ 04-24 发现 | schedule 错配为 `* * * * *`，应为 `59 23 * * *` |
| 早安/下班/健身 cron timeout | ⚠️ consecutiveErrors=2 | 可能是 message 过长或 isolated session 冷启动慢 |
| 23:59 自检（416c934d）error | ⚠️ 04-24 | mode=none 导致错误静默，需改为 announce |
| Checkpoint Skill 等待确认 | ⏳ 04-23 提出，04-24 未回复 | 用户未确认，Iris 未执行 |
| 416c934d timeout 后 session 未清理 | ⚠️ runningAtMs 残留 | 进程杀死后 scheduler 未收到退出信号 |

## Skill 沉淀记录

| Skill | 状态 | 日期 | 说明 |
|------|------|------|------|
| 自驱型 Agent 工作流 | ✅ 已创建 | 04-22 | heartbeat + WAL Protocol + 自主 Cron |
| Checkpoint Pattern | ⏳ 待用户确认 | 04-24 | 还没收到用户回复 |
| facts.md vs .learnings/ 路径不清 | ✅ 已明确 | facts.md = 高层提炼，.learnings/ = 原始日志 |

---

## Skill 沉淀记录

| Skill | 状态 | 说明 |
|------|------|------|
| Checkpoint Skill | ⏳ 待确认（04-23 提出，04-24 未回复）| 方案已提出，未获确认 |
| cron-delivery-mode | 🔍 待创建（高优先级）| isolated session 反复因 mode=none 静默失败 |
| 定时任务-timeout-处理 | 🔍 待调查（中优先级）| 三个任务 timeout 有系统性原因 |

---

## 学到的教训（来自 .learnings/）

1. **删除文件前必须确认备份** — 没有证据不能删除记忆文件，SQLite 是索引层，MD 是原始数据层，两者互补
2. **cron 表达式修改后立即验证 nextRunAtMs** — 防止时间算错（本意 21:30 实际 21:00）
3. **承诺 → 立即执行，不留到下一轮** — 连续多日在自检里承诺"要建 cron"但没实际操作

---

_Version 1.0 — 2026-04-23_
