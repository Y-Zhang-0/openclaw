# OpenClaw 新服务器重装指南

> 参考：`memory/server-migration-backup-2026-05-18.md`
> 生成时间：2026-05-18

---

## 第一步：环境准备

```bash
# 1. 安装 Node.js ≥18
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# 2. 安装 OpenClaw
npm install -g openclaw

# 3. 配置时区
timedatectl set-timezone Asia/Shanghai

# 4. 验证安装
node --version   # ≥18
openclaw --version
```

---

## 第二步：恢复 openclaw.json

从密码管理器或旧服务器备份获取以下信息，创建 `/root/.openclaw/openclaw.json`：

```json
{
  "meta": { "lastTouchedVersion": "2026.3.23" },
  "browser": { "enabled": true, "headless": true, "noSandbox": true },
  "auth": { "profiles": {} },
  "models": {
    "providers": {
      "minimax": {
        "baseUrl": "https://api.minimaxi.com/anthropic",
        "api": "anthropic-messages",
        "authHeader": true,
        "models": [{
          "id": "MiniMax-M2.7",
          "name": "MiniMax M2.7",
          "reasoning": true,
          "input": ["text"],
          "cost": { "input": 0.3, "output": 1.2, "cacheRead": 0.06, "cacheWrite": 0.375 },
          "contextWindow": 204800,
          "maxTokens": 131072
        }]
      }
    }
  },
  "channels": {
    "feishu": {
      "enabled": true,
      "appId": "cli_a96e25c49bf81bcd",
      "appSecret": "替换为你的AppSecret",
      "dmPolicy": "pairing",
      "groupPolicy": "open",
      "requireMention": true
    }
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": {
      "mode": "token",
      "token": "替换为你的GatewayToken"
    }
  }
}
```

> ⚠️ **AppSecret 和 Gateway Token 请从旧服务器备份或飞书开放平台获取**

---

## 第三步：启动 Gateway

```bash
openclaw gateway start
systemctl --user enable openclaw   # 开机自启（可选）
```

---

## 第四步：Clawhub 重装 Skills

```bash
# Marketplace skills 重装列表
clawhub install agent-autopilot
clawhub install agent-browser-clawdbot
clawhub install auto-updater
clawhub install cron-scheduler
clawhub install cron-scheduler-troubleshooter
clawhub install doc-only-commitment-tracker
clawhub install find-skills-skill
clawhub install humanizer
clawhub install iris-self-evolution
clawhub install isolated-session-delivery
clawhub install proactive-agent
clawhub install rss-reader
clawhub install self-improving-agent
clawhub install skill-creator
clawhub install skillscan
clawhub install skill-vetter
clawhub install task-orchestrator
clawhub install todo-management
```

---

## 第五步：重建 Cron Jobs

### 5.1 Watchdog（每小时健康检查）

```bash
openclaw cron add \
  --name "Watchdog" \
  --schedule "cron 0 * * * *" \
  --target isolated \
  --delivery announce \
  --openclaw-script '
gateway_pid=$(pgrep -f "openclaw gateway" | head -1)
if [ -z "$gateway_pid" ]; then
  echo "Gateway down, restarting..."
  systemctl --user restart openclaw
fi
'
```

### 5.2 🌅 早安问候（每天 08:00）

```bash
openclaw cron add \
  --name "🌅早安问候-随机+天气" \
  --schedule "cron 0 8 * * *" \
  --target isolated \
  --delivery announce \
  --model minimax/MiniMax-M2.7 \
  --timeout 120
```

### 5.3 🤖 AI资讯抓取（每天 09:00）

```bash
openclaw cron add \
  --name "🤖AI资讯抓取" \
  --schedule "cron 0 9 * * *" \
  --target isolated \
  --delivery announce \
  --timeout 300
```

### 5.4 💪 健身提醒（周一至周五 19:30）

```bash
openclaw cron add \
  --name "💪准时推送-健身提醒" \
  --schedule "cron 30 19 * * 1-5" \
  --target isolated \
  --delivery announce \
  --model minimax/MiniMax-M2.7 \
  --timeout 60
```

### 5.5 🌙 下班提醒（周一至周五 19:00）

```bash
openclaw cron add \
  --name "🌙下班提醒-随机+天气" \
  --schedule "cron 0 19 * * 1-5" \
  --target isolated \
  --delivery announce \
  --model minimax/MiniMax-M2.7 \
  --timeout 60
```

### 5.6 📚 每日学习推送（每天 21:00）

```bash
openclaw cron add \
  --name "📚每日学习推送" \
  --schedule "cron 0 21 * * *" \
  --target isolated \
  --delivery announce \
  --timeout 180
```

### 5.7 🔍 每日自检-22:00推送

```bash
openclaw cron add \
  --name "🔍每日自检-22:00推送" \
  --schedule "cron 0 22 * * *" \
  --target isolated \
  --delivery announce \
  --timeout 300
```

### 5.8 📝 每日记忆+备份+飞书推送（23:59）

```bash
openclaw cron add \
  --name "📝每日记忆+备份+飞书推送-23:59" \
  --schedule "cron 59 23 * * *" \
  --target isolated \
  --delivery announce \
  --timeout 300
```

### 5.9 🔧 Skill自动更新（每天 04:00）

```bash
openclaw cron add \
  --name "🔧 Skill自动更新" \
  --schedule "cron 0 4 * * *" \
  --target isolated \
  --delivery announce \
  --timeout 180
```

### 5.10 📊 周报生成（周一 09:00）

```bash
openclaw cron add \
  --name "📊周报生成" \
  --schedule "cron 0 9 * * 1" \
  --target isolated \
  --delivery announce \
  --model minimax/MiniMax-M2.7 \
  --timeout 300
```

### 5.11 🧹 周度自进化与清理（周日 03:00）

```bash
openclaw cron add \
  --name "🧹 Iris 周度自进化与清理" \
  --schedule "cron 0 3 * * 0" \
  --target isolated \
  --delivery announce \
  --timeout 300
```

### 5.12 🧠 月度自进化与清理（每月1日 03:00）

```bash
openclaw cron add \
  --name "🧠 Iris 月度自进化与清理" \
  --schedule "cron 0 3 1 * *" \
  --target isolated \
  --delivery announce \
  --timeout 300
```

---

## 第六步：恢复 Git 备份

```bash
# 克隆你的备份仓库
git clone https://github.com/Y-Zhang-0/openclaw.git /root/.openclaw/workspace

# 切换到 develop 分支（日常）
cd /root/.openclaw/workspace
git checkout develop

# 恢复凭据（飞书配对）
cp /path/to/feishu-pairing.json /root/.openclaw/credentials/
```

---

## 第七步：验证清单

```bash
# 1. 检查 cron 列表
openclaw cron list

# 2. 检查 gateway 状态
openclaw gateway status

# 3. 测试飞书消息
curl -H "Authorization: Bearer <token>" http://localhost:18789/health

# 4. 手动触发一次自检
openclaw cron run <自检-job-id>

# 5. 检查记忆文件
ls memory/daily/
```

---

## 故障排查

| 问题 | 解法 |
|------|------|
| `openclaw: command not found` | `npm install -g openclaw` 重装 |
| 飞书收不到消息 | 检查 appId/appSecret，开放平台配置 |
| cron 不触发 | `openclaw gateway restart` |
| Skills 加载失败 | `clawhub install <skill-name>` 重装 |

---

## 快速验收

新服务器恢复完成后，在这个群说"自检"，确认：
1. ✅ 记忆文件正常读取
2. ✅ Cron jobs 状态 OK
3. ✅ 飞书推送正常
4. ✅ AI 资讯抓取正常