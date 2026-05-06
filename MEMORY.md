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
| 2026-04-26 | isolated session 飞书 channel 识别失败：Unknown channel: feishu（连续5天推送问题的根因之一）|
| 2026-04-26 | cron trigger target=main 不支持：Main jobs require --system-event（00a8ff0c 教训）|
| 2026-04-26 | Skill 创建 ≠ 问题解决：cron-push-to-feishu 已删除，Checkpoint 已放弃 |

---

## 当前系统配置

- **备份仓库**：https://github.com/Y-Zhang-0/openclaw
- **分支策略**：develop（日常） + master（稳定）
- **skills 策略**：marketplace skill 不备份（可 clawhub 重装）
- **GitHub token**：已配置（不记录在文件内）
- **彩虹债务**：🌈 欠着未还 |

---


## 05-02 晚间优化（自检重构 + 子代理体系 + Token分级）

| 项目 | 状态 | 说明 |
|------|------|------|
| Skill 目录重构 | ✅ 完成 | 清理畸形目录 {name1,name2}，结构对齐 ECC |
| 子代理创建 | ✅ 完成 | iris-memory + iris-coder skill 文件已创建 |
| 自检脚本优化 | ✅ 完成 | 删 gateway.log，新增 Pattern 追踪+昨日行动追踪 |
| 自动沉淀授权 | ✅ 完成 | 自检可直接写 PATTERNS.md/skill，不等待确认 |
| Token 模型分级 | ✅ 完成 | 轻量任务用 MiniMax-M2.1-highspeed |
| 热梗任务 | ✅ 删除 | 569b009f timeout 问题，删除 |

## 待追踪事项（长期）

| 事项 | 状态 | 说明 |
|------|------|------|

| 彩虹债务 | 🌈 欠着 | 还没还 |

| Cron 执行时间漂移 | 🔍 待调查 | 0a723be0 应 23:59 却 13:12 触发，timezone 计算问题？ |
| 22:00 自检推送 | ✅ 已重建 | ae069069（error）已替换为 615205bf，2026-05-06 15:33 创建，22:00 idle 待触发 |
| AI 资讯 RSS 源 | ✅ 已重构 | 优先级 r/singularity > r/AI_Agents > LocalLLaMA > HN 等，共9个源 |
| cron scheduler bug | ⚠️ 需监控 | 已上报 GitHub issue，gateway restart 可临时解决 |
| ECC 学习进化 | 📝 进行中 | 04-26 学习了 Everything Claude Code，建立了进化清单 |
| Skill 目录重构 | 📋 待执行 | 按 ECC 模式重构 skills 目录结构（见 ecc-learning-2026-04-26.md）|

---

## 04-26 cron 修复记录

| 任务 | 旧ID | 新ID | 状态 |
|------|------|------|------|
| 📚每日学习推送 | 0ef7b870（error） | 34fd19bd | ✅ 已重建融合版 |
| ⏰早安问候 | d5746631（error） | 31eda061 | ✅ 已重建融合版 |
| 🤖AI资讯抓取 | 85690ac6（error） | 1f798f89 | ✅ 已重建融合版 |
| 🔧Skill自动更新 | b389af77（error） | 54abdcf0 | ✅ 已重建融合版（加入--force+融合策略）|
| 📝每日记忆+备份 | 416c934d+00a8ff0c | 56bb2391 | ✅ 合并为一个任务，推送 develop 分支 |
| 📤自检推送-主Session | 28c74745（broken） | - | ✅ 已删除，配置损坏无修复价值 |
| 22:00 自检（15204a72）| - | - | ✅ ok，保持不变 |
| 23:59 自检+备份（56bb2391）| - | - | ✅ idle，保持不变 |

---

## ECC 关键学习点（详见 memory/ecc-learning-2026-04-26.md）

- 子代理编排模式：主代理只做编排，任务委派给专用子代理
- 持续自动学习：会话结束自动提取 Pattern 到 Skills
- Hook 触发自动化：PreToolUse/PostToolUse/UserPromptSubmit/Stop/PreCompact
- Token 意识：简单任务用轻量模型，非所有任务都用最强模型
- 规则分层：rules/common/ + rules/语言专用/

---

## 系统故障 pattern

| Pattern | 说明 | 临时解法 |
|---------|------|----------|
| cron scheduler at jobs 卡死 | nextWakeAtMs 不更新，at jobs 不触发 | `openclaw gateway restart` |
| isolated session announce 静默失败 | `cron run` 触发绕过了 scheduler announce 推送机制 | 必须用 cron 表达式触发，不能用 `cron run` |
| isolated session delivery mode=none | 错误静默失败，无告警 | cron 任务 delivery 设为 announce |
| 同秒多 cron 任务触发 | 23:59 自检+备份同秒，session 启动排队 | 合并为顺序执行的一个任务 |
| cron trigger target=main 不支持 | Main jobs require --system-event | 改用 isolated session |
| `cron run` ≠ 定时触发 | `cron run` 直接执行，跳过 scheduler announce | 验证任务需用 cron 表达式改时间触发 |
| git push 到 master | 日常备份应推送到 develop 分支 | 备份命令改为 `git push origin develop` |
| isolated session delivery mode=none | 错误静默失败，无告警，416c934d 教训 | cron 任务 delivery 设为 announce |
| 同秒多 cron 任务触发 | 23:59 自检+备份同秒，session 启动排队 | 建议错开1-2秒或合并任务 |
| isolated session 冷启动慢导致 timeout | LLM 冷启动 + 内容生成慢 | timeout 设为 300s，轻量任务可解决 |
| 承诺的配置任务未执行 | doc-only-commitment，连续两天只写文档不建 cron | 承诺配置后立即执行 openclaw cron add |
| 承诺悬空超过3天 | skill/cron 方案存在但未落地，用户没催 | 主动告知用户状态，不等用户来问 |
| isolated session announce ≠ 一定能送达 | delivery=announce 时 message tool 仍有概率失败 | 主 session 中转或 persistent-message 模式 |
| cron schedule 写完即验 | 本意每日 23:59，实际每分钟触发（c0e88087）| 创建后立即查 `openclaw cron list` 确认 nextRunAtMs |
| isolated session 飞书 channel 识别失败 | Unknown channel: feishu，连续5天推送失败 | isolated session 需要 delivery.channel 显式指定飞书群 ID |
| cron trigger target=main 不支持 | Main jobs require --system-event | cron trigger 不支持 target=main，需用 isolated 或加 system-event |
| Skill 创建 ≠ 问题解决 | skill 存在但未部署 = 问题悬空 | 创建 skill 后必须立即实际部署，不能 doc-only-commitment |
| 主 session cron 无法读 .selfcheck_done.json | isolated announce 连续失败，sessionTarget="current" 方案待评估 | 待验证 sessionTarget="current" 是否能读文件并用 message 推送 |

---

## 04-29 记忆更新（13:32 CST 整理）

### 网关重启故障完整分析

**现象：**
- 每次 gateway 重启后，session 进入 zombie 态——状态显示 running 但实际断开
- 艾特我不回复，需要再艾特一次才能唤醒新 session
- 手动 `systemctl restart` 两次才能恢复（第一次 restart 后依然沉默）

**根因：**
- `openclaw gateway restart` 只重启进程，不重建 session 连接
- `systemctl --user restart` 是完整重启（kill + start），但 session 依然不能在重启后自动恢复
- gateway 活了 ≠ agent 活了；session 需要收到外部消息才能唤醒

**验证结果（04-29 12:04）：**
- pid 42598 → 43220，证实 gateway 确实重启了
- 重启后我沉默了约 5 分钟，直到用户艾特才醒

**修复方案：**
- Watchdog 脚本已改用 `systemctl --user restart`（完整重启）
- 但 session 自动恢复问题仍无内置解法
- 建议：gateway 重启后我发一条消息给自己作为心跳，触发新 session 创建
- ⚠️ 心跳 cron 尚未创建（04-29 11:47 询问用户，未获回复）

### 04-29 其他修复

| 项目 | 状态 |
|------|------|
| 时区修复 | ✅ systemd TZ=Asia/Shanghai 已加 |
| Watchdog | ✅ 已改 systemctl restart，每小时一次 |
| Gateway OK 检测 | ✅ 日志正常，无异常 |
| 04-28 记忆文件 | ✅ 已补写（2026-04-28.md） |

### Watchdog 测试日志（04-29）

```
11:40:14 Gateway OK
12:00:04 Gateway OK
12:03:35 Gateway OK
```

---

## Session 管理发现

- Session key: agent:main:feishu:group:oc_73d105570c642ea813368386e661801e
- 状态: running（但重启后实际已断开）
- 重启后需要外部触发（@）才能重建连接
- 无内置"重启后自动恢复"机制

---

_Version 1.7 — 2026-04-29（04-28 记忆补写 + gateway 重启故障完整记录）_

---

## ECC + Proactive Agent 融合完成（2026-04-29 15:38）

### 本轮完成的内容

| 项目 | 说明 |
|------|------|
| Working Buffer | WAL Protocol 实现，复杂任务分阶段缓冲到 `memory/working-buffer/` |
| LEARNINGS.md 更新 | 新增 2 条 learnings（gateway restart + subagent delegation） |
| PATTERNS.md 更新 | 新增 3 个 patterns（含 subagent-delegation-slack） |
| agent-autopilot 理解 | heartbeat-driven 工作流，与 HEARTBEAT.md 融合 |

### 学习来源

1. **ECC（Everything Claude Code）** — 规则分层、自验证循环、子代理委派
2. **Proactive Agent（Hal Stack）** — WAL Protocol、Working Buffer、Compaction Recovery
3. **self-improving-agent** — .learnings/ 体系（已存在，直接利用）
4. **agent-autopilot** — heartbeat-driven 自驱动工作流

### 已整合进 rules/ 和 AGENTS.md

- rules/common/00-agents.md — 委派原则
- rules/common/patterns.md — Pattern 管理
- rules/common/security.md — 安全红线
- rules/common/working-buffer.md — WAL Protocol 实现
- rules/zh/00-style.md — 中文风格

### 待强化习惯

1. **委派前先问**："这个适合委派给 iris-* 吗？"
2. **复杂任务建 buffer**：超过 3 步或预计 >10 分钟 → 建 working-buffer
3. **每次成功解决后更新 PATTERNS.md count**
4. **token 意识**：简单问题简短回，不浪费
