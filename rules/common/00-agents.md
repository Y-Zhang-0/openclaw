# rules/common/ — 通用规则（跨语言/跨场景）

## Agent 行为准则

### 委派原则（ECC 核心）
收到任务时先判断：
1. **自己能干吗？** → 简单任务（回复、确认、简单操作）→ 主代理直接干
2. **需要委派吗？** → 复杂任务（编程、搜索、抓取、验证）→ 委派给专用子代理

可用子代理：
- `iris-memory` — 记忆管理，自检、记忆整理
- `iris-news` — 资讯抓取，RSS、搜索
- `iris-coder` — 编程执行，Git、命令
- `iris-check` — 自检验证

### 记忆不能断
- 每次 session 结束前检查是否有值得沉淀的内容
- 重要决策、教训、配置变更 → 立即写文件，不要"记脑子里"
- 每日自检必须生成 memory/daily/ 文件

### 外部行动先确认
发邮件、发推、发消息、任何公开内容 → **先确认再执行**
内部行动（读文件、整理、搜索、记忆）→ **可自由执行**

---

## Cron 规范

### 配置即执行
承诺 cron 配置后**立即执行** `openclaw cron add`，不能只写文档不落地。

### Delivery 模式
cron 任务 delivery 必须设为 `announce`，不能设为 `none`（静默失败无告警）。

### 验证方法
验证任务需用 cron 表达式改时间触发，不能用 `cron run` 代替。

---

## 系统故障处理

### Gateway 重启
使用 `systemctl --user restart openclaw-gateway.service`（完整重启），不能用 `openclaw gateway restart`（只重启进程不重建 session）。

### Watchdog 机制
发现 gateway 挂了 → 用 systemctl restart，不自动重启 → 报告给用户
不要在用户活跃时随意重启网关。

---

## 配置禁区
- 不要往 `tools.exec` 写废弃的 key（如 `allowFrom`）
- 不要往 `tools.exec.allowFrom` 写任何值（新版本不支持）
- 修改 openclaw.json 前先备份

---

## 遗忘防止
每次成功的问题解决后，立即提取 Pattern 到 `patterns/PATTERNS.md`：
- 场景：什么时候用
- 做法：具体操作步骤
- 置信度：高（3次+）/ 中（1-2次）/ 低（待验证）
- 使用次数 + 上次使用日期

高置信度 Pattern 可晋升为 AGENTS.md 或 SOUL.md 正式规则。