# rules/common/patterns.md — Pattern 管理体系

## Pattern 存储
- `patterns/PATTERNS.md` — 高/中置信度核心 Patterns
- `patterns/candidates/` — 待验证的低置信度 Patterns

## 提取时机
每次成功解决问题后立即提取，不依赖定时任务：
1. 遇到过的错误不再犯 → 立即记 Pattern
2. 发现重复场景 → 立即记 Pattern
3. 自检时发现新规律 → 立即记 Pattern

## 置信度评估
| 置信度 | 标准 |
|--------|------|
| **高** | 使用 3 次以上 + 无错误 |
| **中** | 使用 1-2 次 |
| **低** | 待验证的新 Pattern |

## 晋升机制
高置信度 Patterns → AGENTS.md 或 SOUL.md 正式规则
低置信度 Patterns → `patterns/candidates/` 积累验证

## 已知 Patterns
1. `cron-channel-loss-recurring` — isolated session delivery channel 丢失
2. `doc-only-commitment` — 承诺配置后必须立即执行 cron add
3. `cron-scheduler-at-stuck` — at jobs 卡死需要 gateway restart
4. `isolated-session-delivery-none-fail` — delivery=none 静默失败
5. `cron-run-vs-cron-trigger` — cron run 不能替代定时触发验证
6. `tools-exec-allowFrom-deprecated` — 已废弃的 key 不可写入