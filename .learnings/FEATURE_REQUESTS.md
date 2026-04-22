# Feature Requests

Capabilities requested by the user.

---

## 本轮自检发现（2026-04-22 晚间）

### Pattern: cron-delivery-none-silent-failure
**来源**：cron 任务 delivery.mode="none" 会导致执行结果不推送到聊天。如果任务本意是让用户看到结果，必须设为 announce。

**影响**：🤖AI资讯抓取 今天（2026-04-22）执行结果为 not-delivered，用户看不到。

**建议**：在创建 cron 任务时，明确是否需要用户看到结果——如果需要，delivery 必须是 announce，不能是 none。

### Pattern: cron-config-confirmation
**来源**：用户自行修改 cron 配置后，作为自检任务没有在下午前主动确认这些任务是否生效。

**建议**：cron 大规模修改后，主动在下一个运行时间点前后确认执行结果，形成习惯。

### Pattern: dual-cron-conflict
**来源**：系统 crontab 和 OpenClaw cron 并存，下班提醒重复执行。

**建议**：发现两套 cron 并存时主动报告用户，说明影响，让用户选择。