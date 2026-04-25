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
| 2026-04-24 | cron 表达式写完立即验证 nextRunAtMs（本意每分钟实际每分钟，T2记忆 cron 教训）|
| 2026-04-25 | isolated session delivery mode=none = 错误静默失败（416c934d 教训）|
| 2026-04-25 | 同秒多 cron 任务触发需评估启动时序（23:59 自检+备份同秒，先触发的可能排队）|

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
| Checkpoint Skill | ⏳ 待确认 | 方案已提出（04-23→04-24→04-25，用户仍未回复）|
| 彩虹债务 | 🌈 欠着 | 还没还 |
| 三个 timeout cron 调查 | 🔍 待处理 | 早安/下班/健身提醒 consecutiveErrors=2，需查是 message 过长还是冷启动问题 |
| isolated session delivery mode=none | ✅ 已修复 | 416c934d 已改用 announce+feishu channel |
| AI 资讯 RSS 源 | ✅ 已重构 | 优先级 r/singularity > r/AI_Agents > LocalLLaMA > HN 等，共9个源 |
| rss-reader scripts 清理 | ✅ 已完成 | ai-news-digest.sh 等脚本已删除 |
| cron scheduler bug | ⚠️ 需监控 | 已上报 GitHub issue，gateway restart 可临时解决 |
| 22:00 自检（8864ceed）| ⚠️ error | 04-25 22:00 新增 error，consecutiveErrors=1，需观察 |
| 📚每日学习推送 21:00（0ef7b870）| ⚠️ error | 04-25 20:00 error，consecutiveErrors=1，需观察 |
| 🔧 Skill自动更新（b389af77）| ⚠️ error | 04-25 04:00 error，consecutiveErrors=1，下次 04-26 04:00 |
| GitHub备份 23:59 | ✅ ok | 任务 ID 00a8ff0c |
| 🤖AI资讯抓取 09:00 | ✅ ok | 任务 ID 85690ac6 |
| 08:00 早安问候 | ✅ ok | 04-24 delivered=true |
| 19:00 下班提醒 | ✅ ok | 04-24 delivered=true |
| 19:30 健身提醒 | ✅ ok | 04-24 delivered=true |

---

## 系统故障 pattern

| Pattern | 说明 | 临时解法 |
|---------|------|----------|
| cron scheduler at jobs 卡死 | nextWakeAtMs 不更新，at jobs 不触发 | `openclaw gateway restart` |
| isolated session 飞书 announce 400 | announce 模式在 isolated session 里有时报 400 | 改用 delivery announce+feishu channel 可解 |
| isolated session delivery mode=none | 错误静默失败，无告警，416c934d 教训 | cron 任务 delivery 设为 announce |
| 同秒多 cron 任务触发 | 23:59 自检+备份同秒，session 启动排队 | 建议错开1-2秒或合并任务 |
| isolated session 冷启动慢导致 timeout | LLM 冷启动 + 内容生成慢 | timeout 设为 300s，轻量任务可解决 |
| 承诺的配置任务未执行 | doc-only-commitment，连续两天只写文档不建 cron | 承诺配置后立即执行 openclaw cron add |
| isolated session announce ≠ 一定能送达 | delivery=announce 时 message tool 仍有概率失败 | 主 session 中转或 persistent-message 模式 |
| cron schedule 写完即验 | 本意每日 23:59，实际每分钟触发（c0e88087）| 创建后立即查 `openclaw cron list` 确认 nextRunAtMs |
