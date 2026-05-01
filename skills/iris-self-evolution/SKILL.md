---
name: Iris-Self-Evolution
slug: iris-self-evolution
version: 1.1.0
description: "Iris's autonomous self-evolution system: pattern沉淀, skill lifecycle management, and periodic optimization. ECC-driven continuous learning."
metadata: {"version":"1.1.0","author":"Iris","purpose":"self-evolution"}
---

# Iris-Self-Evolution Skill

## 核心原则

1. **方案先行**：新增 cron/skill 前先出方案给用户确认
2. **记忆不能断**：每次 session 确保重要内容有沉淀
3. **不乱删**：没有证据不删除任何文件
4. **ECC驱动**：每次成功解决问题后自动提取 Pattern 并更新

---

## Pattern 管理（ECC 持续学习）

### 触发时机
- 每次成功的问题解决后
- 每次犯错被用户纠正后
- 每次发现更好方案后

### Pattern 格式
```markdown
#### Pattern-名称
- 场景：什么时候用
- 做法：具体操作步骤
- 置信度：高（3次以上+无错）/ 中（1-2次）/ 低（待验证）
- 使用次数：持续累计
- 上次使用：每次使用后更新
```

### 置信度晋升规则
- 低 → 中：连续使用 3 次且无错
- 中 → 高：连续使用 5 次且无错

---

## Skill 生命周期管理

### 自优化触发条件
每次 cron 任务（自检/备份/Skill更新）完成后，agent 自动检查：
1. 这次执行有没有问题？
2. 有没有值得沉淀的新 Pattern？
3. 有没有可以优化的 skill 配置？

### Skill 健康状态分类
| 状态 | 定义 | 处理方式 |
|------|------|----------|
| ✅ 健康 | 60 天内有更新，使用正常 | 保持 |
| ⚠️ 待优化 | 超过 60 天未更新 | 月度清理时处理 |
| 🔴 失效 | 依赖的功能已不存在 | 删除或重建 |

---

## 定期优化任务

### 周度（每周日 03:00）
| 任务 | 输出 |
|------|------|
| Cron 复盘 | error 次数统计 |
| jsonl 清理（保留30天） | 清理数量 |
| Pattern 验证（candidates → PATTERNS.md） | 晋升数量 |
| Skill 健康检查 | 待优化列表 |
| 本周异常汇总 | 异常统计 |

### 月度（每月1日 03:00）
| 任务 | 输出 |
|------|------|
| Skill 全面清理 | 删除数量 |
| Pattern 归档整理 | 整理结果 |
| 记忆复盘（清理3个月前旧文件） | 清理数量 |
| MEMORY.md 更新 | 更新内容 |
| 异常深度复盘 | 处理结果 |

---

## Skill 自动更新融合策略

当 clawhub update 触发冲突：
- SKILL.md instruction 部分：优先保留 Iris 的理解和定制化表述
- scripts/：本地修改优先，新版逻辑作参考
- 冲突时不过滤不覆盖，用 Iris 判断决定保留什么

---

## 禁止事项

- 不能在未经用户确认的情况下新增 cron/skill
- 不能因为"优化"删除没有备份的记忆文件
- 不能用 HEARTBEAT_OK 掩盖实际问题
