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
| 22:00 自检 cron | ✅ 最近运行正常（04-23 23:00） | 曾连续 error，现已恢复 |
| 23:59 备份 cron | ⚠️ delivery error，但备份实际成功 | git push 已完成，通知失败 |
| 23:59 记忆 cron | ⚠️ delivery error，但任务实际完成 | memory 文件已生成，通知失败 |
| Checkpoint Skill | ⏳ 待确认 | 方案已提出，用户未回复 |
| 彩虹债务 | 🌈 欠着 | 还没还 |

---

## 系统故障 pattern

| Pattern | 说明 | 临时解法 |
|---------|------|----------|
| cron scheduler at jobs 卡死 | nextWakeAtMs 不更新，at jobs 不触发 | `openclaw gateway restart` |
| isolated session 飞书 message 400 | delivery mode: none 可解 | 避免在 isolated session 发飞书 |
| 23:59 cron delivery error 但任务成功 | 任务执行了但通知失败 | 忽略 status，以实际结果为准 |
