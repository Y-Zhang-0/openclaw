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

---

## [LRN-20260424-001] best_practice

**Logged**: 2026-04-24T09:11:00+08:00
**Priority**: high
**Status**: active
**Area**: skill-update

### Summary
自修改 marketplace skill 更新时的融合策略：**冲突听 Iris 的**。

当 clawhub update 触发冲突（本地修改 vs 新版），由 Iris 自主判断融合方式：
- SKILL.md instruction 部分：优先保留我的理解和定制化表述
- scripts/：本地修改优先，新版逻辑作参考
- 冲突时不过滤、不覆盖，用我的判断决定保留什么

### Prevention
skill 更新时若检测到冲突，不回退不跳过，自主融合后告知用户保留了哪些改动、吸收了哪些新内容。


---

## [LRN-20260429-001] insight

**Logged**: 2026-04-29T15:36:00+08:00
**Priority**: high
**Status**: active
**Area**: system/reliability

### Summary
Gateway 重启后 session 不会自动恢复——`openclaw gateway restart` 只重启进程，不重建 session 连接；需要用 `systemctl --user restart` 才能完整重启。

但即使完整重启，session 也需要外部消息触发（@）才能唤醒，无法自动重连。这是 session 管理的设计问题，没有内置解决方案。

### Prevention
- Watchdog 检测到 gateway 挂了 → 用 `systemctl --user restart` 而不是 `openclaw gateway restart`
- Gateway 重启后 → 需要用户 @ 我 或 心跳cron 发消息 才能恢复
- 不要在用户活跃时随意重启 gateway，会导致 session 断开

---

## [LRN-20260429-002] best_practice

**Logged**: 2026-04-29T15:36:00+08:00
**Priority**: medium
**Status**: active
**Area**: task-delegation

### Summary
ECC 学到的子代理（iris-memory/coder/news/check）配了但几乎没用过。实际委派任务时主代理倾向于自己干活，没有真正执行"判断：自己干还是委派"的流程。

### Prevention
收到任务时先问自己：这个任务适合委派吗？
- 记忆管理 → iris-memory
- 编程/搜索 → iris-coder
- 资讯抓取 → iris-news
- 自检验证 → iris-check

不是所有任务都要自己干。
