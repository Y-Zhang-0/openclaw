# HEARTBEAT.md

## 定时任务

### 每 6 小时 — 长期记忆维护
读取 memory/daily/ 目录，提炼重要内容到 MEMORY.md，清理过时信息。
无需汇报，完成后静默更新。

### 每小时 — Watchdog
检查 gateway 状态，发现挂了用 systemctl restart，记录到 watchdog.log。

---

## 自验证循环（每次 session 结束自动运行）

每次成功解决问题后，自动执行以下检查：

### 1. Pattern 提取
- 遇到新错误/教训 → 立即追加到 patterns/PATTERNS.md
- 不依赖手动，定期检查 patterns/ 目录是否需要补充

### 2. 记忆沉淀
- 重要配置变更 → 立即写文件
- 不"记脑子里"，写进 memory/daily/

### 3. Cron 状态检查
- 检查是否有未完成的承诺（skill/cron 已建但未落地）
- 发现 doc-only-commitment 立即补上

---

## 进度通知机制

- **子任务完成** → sessions_spawn 的 announce 自动推送
- **所有子任务完成** → 主 agent 汇总后推送完整报告
- **遇到阻塞** → 立即推送告知，不等待

---

## 低频维护任务

- 记忆文件整理
- facts.md 更新
- patterns/candidates/ 里的低置信度 Pattern 验证

不主动汇报结果。