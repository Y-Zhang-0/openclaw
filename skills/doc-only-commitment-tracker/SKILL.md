---
name: Doc-Only-Commitment-Tracker
slug: doc-only-commitment-tracker
version: 1.0.0
description: "防止只写文档不落地执行的 Pattern：承诺配置后必须立即执行 openclaw cron/skill add"
metadata: {"version":"1.0.0","author":"Iris","purpose":"prevent-doc-only-commitment"}
---

# Doc-Only-Commitment-Tracker

> 每次承诺配置 cron/skill 后，必须立即执行 `openclaw cron add` / `openclaw skill add`，不能只写文档不落地。

## Pattern: doc-only-commitment

| 字段 | 内容 |
|------|------|
| **场景** | 承诺配置 cron/skill 后只写文档，未实际执行 `openclaw cron add` |
| **做法** | 承诺配置后**立即执行** `openclaw cron add`，不能只写文档不落地 |
| **置信度** | 高（已出现 3+ 次） |
| **使用次数** | 持续累计 |
| **上次使用** | 每次犯同样错误时更新 |

## 触发时机

在以下情况下，承诺后必须立即执行：
- 讨论 cron 任务配置 → 确认后立即 `openclaw cron add`
- 讨论 skill 部署 → 确认后立即 `openclaw skill add`
- 讨论方案 → 用户确认后立即执行，不能说"等我先写文档"

## 验证清单

承诺配置后检查：
- [ ] `openclaw cron add` 是否已执行
- [ ] 新 cron ID 是否已知
- [ ] cron list 里是否能查到

## 关联 Pattern

- **Pattern-方案先行**：新增 cron/skill 前先出方案给用户确认
- 两者结合：先确认方案 → 确认后立即执行
