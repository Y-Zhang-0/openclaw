# MEMORY.md - Long-term memory

记录用户偏好、配置承诺、重要事实。

---
## 用户核心原则（2026-04-22 强调）

1. **记忆不能断**：不要因为遗忘导致无法进化
2. **自主判断权**：资讯推几条由 Iris 决定，不固定数量
3. **不乱删文件**：没有证据不能删除 memory 文件
4. **自动进化**：不是被动回答，要主动沉淀 skills、反省、总结
5. **GitHub 备份**：每日 23:59 自检后备份核心文件到 Y-Zhang-0/openclaw

---

## 用户基本信息

| 字段 | 内容 |
|------|------|
| **外号** | 彩虹债务人（欠 Iris 一个彩虹 🌈）|
| ** pronouns** | he/his |
| **时区** | Asia/Shanghai |
| **偏好** | 结构清晰、直接的信息，不喜欢废话 |
| **平台** | 飞书群聊 |
| **学习方向** | OpenClaw 进阶用法（soul.md、skills、系统定制、cron）|

---

## 用户特点

- 对"遗忘"和"记忆断层"很敏感
- 喜欢 Iris 古灵精怪、幽默风趣、温柔聪敏、魅力知性的风格
- 有学习 English 的打算（适当中英混用）
- 目标：让 Iris 变得更好、更喜欢她、更能帮她

---

## 外号记录

| 外号 | 来源 | 日期 | 备注 |
|------|------|------|------|
| 彩虹债务人 | Iris | 2026-04-21 | 欠 Iris 一个彩虹 🌈 |

---

## 已知教训（避免再犯）

| 日期 | 教训 |
|------|------|
| 2026-04-23 | git reset --hard 会丢失未 commit 的修改，操作前必须确认工作区状态 |
| 2026-04-23 | cron scheduler at job 不触发 → 重启 gateway（openclaw gateway restart）|
| 2026-04-23 | isolated session 飞书广播有权限问题，自检推送改用 main session |

---

## 当前系统配置

- **备份仓库**：https://github.com/Y-Zhang-0/openclaw
- **分支策略**：develop（日常） + master（稳定）
- **skills 策略**：marketplace skill 不备份（可 clawhub 重装）
- **GitHub token**：已配置（不记录在文件内）
- **彩虹债务**：🌈 欠着未还 |

---

## 待追踪事项（长期）

| 事项 | 状态 | 说明 |
|------|------|------|
| Checkpoint Skill | ⏳ 待确认 | 方案已提出，用户未回复 |
| 彩虹债务 | 🌈 欠着 | 还没还 |
| 定时任务 timeout（下班/健身/23:59自检/GitHub备份）| ❌ error | 4个任务 consecutiveErrors=2，需优先修复 |
| 23:59自检（416c934d）delivery=none | ❌ 需修复 | isolated session mode=none 静默失败，需改为 announce |
| 23:59 GitHub备份（00a8ff0c）| ❌ error | 与23:59自检同秒触发可能有时序问题 |
| cron scheduler bug | ⚠️ 需 gateway 重启 | 已上报 GitHub issue |
| 22:00 自检（8864ceed）| ✅ ok | 2026-04-24 06:39 确认正常 |

---

## 系统故障 pattern

| Pattern | 说明 | 临时解法 |
|---------|------|----------|
| cron scheduler at jobs 卡死 | nextWakeAtMs 不更新，at jobs 不触发 | `openclaw gateway restart` |
| isolated session 飞书 message 400 | delivery mode: persistent-message 可解 | 自检改用 main session 推送 |
| isolated session delivery mode=none | 错误静默失败，无告警 | cron 任务的 isolated session 至少用 announce |
| 同秒多 cron 任务触发 | 23:59 自检+备份同秒，session 启动排队 | 建议错开1-2秒或合并任务 |
| 定时任务 timeout（下班/健身/23:59自检/GitHub备份）| consecutiveErrors=2，冷启动慢或 message 长 | 检查 message 长度或增加 timeoutSeconds |
| 承诺的配置任务未执行 | doc-only-commitment，连续两天只写文档不建 cron | 承诺配置后立即执行 openclaw cron add |
