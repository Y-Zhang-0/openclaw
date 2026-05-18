# 未备份内容清单

> 生成时间：2026-05-18
> 备份策略：git 仅备份 workspace，OpenClaw 内部数据不在备份范围

---

## 一、已备份（无缝衔接）

```
workspace/
├── AGENTS.md / SOUL.md / USER.md / IDENTITY.md   # 核心人格配置
├── memory/daily/                                  # 所有日常记忆文件
├── MEMORY.md / facts.md / HEARTBEAT.md           # 长期记忆+心跳配置
├── patterns/                                      # Pattern 沉淀
├── rules/                                         # 分层规则
├── agents/                                        # 子代理配置
├── skills/                                        # 全部自定义 skill（含 clawhub 安装的）
└── .learnings/                                    # 学习记录
```

---

## 二、未备份（需要重建）

### 2.1 Cron Jobs（13个）

| 名称 | Schedule | 状态 |
|------|----------|------|
| Watchdog | `cron 0 * * * *` | ok |
| 🌙下班提醒-随机+天气 | `cron 0 19 * * 1-5` | ok |
| 💪准时推送-健身提醒 | `cron 30 19 * * 1-5` | ok |
| 📚每日学习推送 | `cron 0 21 * * *` | error |
| 🔍每日自检-22:00推送 | `cron 0 22 * * *` | ok |
| 📝每日记忆+备份+飞书推送-23:59 | `cron 59 23 * * *` | ok |
| 🔧 Skill自动更新 | `cron 0 4 * * *` | ok |
| 🌅早安问候-随机+天气 | `cron 0 8 * * *` | ok |
| 🤖AI资讯抓取 | `cron 0 9 * * *` | ok |
| 🧹 Iris 周度自进化与清理 | `cron 0 3 * * 0` | ok |
| 📊周报生成 | `cron 0 9 * * 1` | ok |
| 🧠 Iris 月度自进化与清理 | `cron 0 3 1 * *` | idle |

> 重装后需在新服务器上重新创建，命令参考 `SETUP_GUIDE.md`

### 2.2 OpenClaw 核心配置

**文件位置：** `/root/.openclaw/openclaw.json`

**包含内容：**
- MiniMax API Key（minimax:global / minimax:cn）
- Gateway 认证 Token
- Feishu Channel AppId + AppSecret
- 插件启用状态
- 浏览器配置

**备份状态：** ❌ 不在 git 备份中（包含密钥）

### 2.3 凭据文件

```
/root/.openclaw/credentials/
├── feishu-pairing.json       # 飞书配对信息
└── feishu-default-allowFrom.json
```

### 2.4 本地数据库

```
/root/.openclaw/openclaw.db   # SQLite（cron job 存储在此）
```

### 2.5 Marketplace Skills（可重装）

以下 skills 来自 Clawhub，重装命令：`clawhub install <skill-name>`

- `agent-autopilot`
- `agent-browser-clawdbot`
- `auto-updater`
- `cron-best-practices`（非 clawhub）
- `cron-scheduler`
- `cron-scheduler-troubleshooter`
- `doc-only-commitment-tracker`
- `find-skills-skill`
- `humanizer`
- `iris-self-evolution`
- `isolated-session-delivery`
- `proactive-agent`
- `rss-reader`
- `self-improving-agent`
- `skill-creator`
- `skillscan`
- `skill-vetter`
- `task-orchestrator`
- `todo-management`

### 2.6 系统级配置（在新服务器上配置）

- Node.js 环境
- systemd 服务配置
- 时区（Asia/Shanghai）
- OpenClaw 全局安装路径

---

## 三、恢复优先级

### P0（必须，新服务器首步）
1. 安装 Node.js ≥18
2. 安装 OpenClaw：`npm install -g openclaw`
3. 配置 openclaw.json（从密码管理器获取密钥）
4. 启动 gateway：`openclaw gateway start`

### P1（登录后立即）
5. 执行 `clawhub install` 重装所有 marketplace skills
6. 重建所有 cron jobs（参考 SETUP_GUIDE.md）
7. 恢复飞书配对（credentials/ 目录）

### P2（验证）
8. 检查每个 cron job 是否正常触发
9. 验证飞书消息收发
10. 跑一次自检确认记忆系统正常