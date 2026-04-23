# Learnings

Corrections, insights, and knowledge gaps captured during development.

**Categories**: correction | insight | knowledge_gap | best_practice

---


## [LRN-20260422-001] best_practice

**Logged**: 2026-04-22T09:44:00+08:00
**Priority**: high
**Status**: promoted
**Area**: memory

### Summary
没有证据不能删除用户的记忆文件。SQLite 是搜索层，MD 文件是原始数据层，两者不是替代关系而是互补关系。之前向用户说"和 SQLite 重复"导致删除了 memory 文件，造成记忆断层——这是严重的判断失误。

### Validation
用户明确说："你不是说sqllite会保存每一天的吗，怎么今天又不保存了"——说明我之前承诺了但没做到，且在没有证据的情况下误导用户删除文件。

### Prevention
删除任何 workspace 文件前，必须：1) 有明确用户授权 2) 确认是否已备份 3) 说明删除原因和影响。

---

## [LRN-20260422-002] best_practice

**Logged**: 2026-04-22T09:44:00+08:00
**Priority**: high
**Status**: active
**Area**: config

### Summary
定时任务调整后，立即验证 nextRunAtMs 是否合理。如果 crontab 表达式修改后时间反而提前了，说明计算错误（本意是将下班提醒从19:00改到21:00，但 0 21 实际是21:00而非21:30）。

### Prevention
修改 cron 表达式后，用 timestamp converter 验证 nextRunAtMs 是否符合预期。


## [LRN-20260422-003] knowledge_gap

**Logged**: 2026-04-22T09:51:00+08:00
**Priority**: medium
**Status**: active

### Summary
OpenClaw 有两套 cron 系统：1) OpenClaw cron (jobs.json) 2) 系统 crontab (crontab -l)。cron-scheduler skill 管理的是后者，不是前者。两者独立运行，会重复。

### Resolution
在删除系统 crontab 里的 offwork-message.sh 前，先确认用户是否同意。

---

## [LRN-20260422-004] correction

**Logged**: 2026-04-22T21:40:00+08:00
**Priority**: high
**Status**: active
**Area**: cron

### Summary
cron 任务 delivery.mode="none" 会导致执行结果不推送给用户。今天 AI 资讯抓取任务 delivery=none，今日执行结果为 not-delivered，用户看不到资讯内容。已将该任务 delivery 改为 announce。

### Prevention
创建 cron 任务时明确该任务是否需要用户看到结果——如果需要看到，delivery 必须是 announce。delivery=none 仅适用于纯后台任务（结果写文件、触发其他系统等）。

