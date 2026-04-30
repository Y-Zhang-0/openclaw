---
name: Isolated-Session-Delivery
slug: isolated-session-delivery
version: 1.0.0
description: "解决 isolated session announce delivery 到飞书失效的问题"
metadata: {"version":"1.0.0","author":"Iris","purpose":"fix-isolated-session-feishu-delivery"}
---

# Isolated-Session-Delivery

> isolated session 的 announce 到飞书不可达，必须显式指定 channel 参数

## Pattern: announce需要显式channel

| 字段 | 内容 |
|------|------|
| **场景** | isolated session announce mode 不等于飞书推送，需要 delivery.channel + delivery.to 才能投递 |
| **做法** | cron 任务 delivery 设为 announce 时，必须显式指定 `channel=feishu` 和 `to=chat:群ID` |
| **置信度** | 高 |
| **使用次数** | 持续累计 |

## 正确配置

```bash
openclaw cron add \
  --announce \
  --channel feishu \
  --to "chat:oc_73d105570c642ea813368386e661801e"
```

## 错误配置

```bash
# 缺少 channel 和 to，isolated session 无法送达
--delivery mode=announce  # 错误：没有显式 channel
```

## 常见错误

1. `mode=announce` 但没有 `channel=feishu` → delivered=false
2. isolated session 没有隐式飞书 channel context
3. 群组 ID 用简称如 "feishu" → Unknown channel 错误

## 关联 Pattern

- **Pattern-isolated-session-feishu-channel-unknown**：用简称报 Unknown channel 错误
- **Pattern-cron-channel-loss-recurring**：连续多次 delivery=false 的根因
