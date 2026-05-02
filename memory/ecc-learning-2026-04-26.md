# ECC 学习进化清单
> Everything Claude Code 冠军体系学习记录
> 吸收日期：2026-04-26
> 来源：Affaan Mustafa (Anthropic Hackathon Winner)

---

## 一、核心差距分析

| 维度 | ECC | 我们现状 | 差距 |
|------|-----|---------|------|
| 子代理数量 | 38个专用 | 少数几个 | 子代理体系不完整 |
| Skills 数量 | 156个 | 约10个 | 技能沉淀不足 |
| Hook 自动化 | 完整钩子体系 | 只有HEARTBEAT | 无触发钩子 |
| 持续学习 | 自动提取pattern | 手动自检 | 缺乏自动机制 |
| Token管理 | 模型分级+压缩 | 无 | 模型单一 |
| 安全规则 | 1282条测试 | 无 | 几乎空白 |
| 规则分层 | common+语言专用 | 统一AGENTS | 无语言分层 |

---

## 二、学习项目清单

### 🔴 高优先级（立即可做）

#### 1. 技能分层结构（Skill Taxonomy）
**ECC做法**：`skills/coding-standards/`、`skills/backend-patterns/`、`skills/tdd-workflow/` — 按领域分层

**我们的现状**：skills/ 目录扁平，混在一起

**行动**：
- [ ] 重构 `~/.openclaw/skills/` 目录，按功能/领域分层
- [ ] 建立 `skills/自我管理/`（自检、记忆、反省）
- [ ] 建立 `skills/任务执行/`（抓取、搜索、编程）
- [ ] 建立 `skills/用户交互/`（推送、提醒、问答）
- [ ] 建立 `skills/系统维护/`（备份、更新、健康检查）

#### 2. 子代理委派模式（Subagent Orchestration）
**ECC做法**：主代理只做编排，子代理单一职责，互不干扰

**我们的现状**：有时主代理直接干活，不擅委派

**行动**：
- [ ] 为每个高频任务创建专用子代理配置
- [ ] 建立 `/memory/` → 记忆管理子代理
- [ ] 建立 `/research/` → 资讯抓取子代理
- [ ] 建立 `/coding/` → 代码执行子代理
- [ ] 主代理收到任务先判断：自己干还是委派？

#### 3. 持续自动学习（Continuous Learning）
**ECC做法**：会话结束后自动提取模式到 Skills

**我们的现状**：需要手动触发自检才能沉淀

**行动**：
- [ ] 建立 `/patterns/` 目录存放提取的Pattern
- [ ] 每次成功的问题解决，自动记录到 `patterns/` 并标注置信度
- [ ] 建立 Pattern 的「好/中/差」评级，差的Review后改进
- [ ] 置信度评分机制：重复使用3次以上 + 无错误 = 高置信度

#### 4. Hook 触发自动化
**ECC Hook类型**：PreToolUse、PostToolUse、UserPromptSubmit、Stop、PreCompact

**我们的现状**：只有 cron heartbeat，无事件驱动钩子

**行动**：
- [ ] 实现 `会话结束钩子`：自动保存上下文摘要到 memory/
- [ ] 实现 `上下文压缩前钩子`：在压缩前保留关键信息
- [ ] 实现 `工具执行后钩子`：自动记录操作结果到 facts.md

---

### 🟡 中优先级（1-2周内）

#### 5. Token/上下文管理意识
**ECC做法**：按任务复杂度选择模型，启用太多工具会导致上下文爆炸

**我们的现状**：所有任务用同一模型

**行动**：
- [ ] 简单任务（如确认/回复）用轻量模式，节省 token
- [ ] 复杂任务（编程/分析）用完整模式
- [ ] 上下文超过 80% 时主动触发压缩，不等系统强制

#### 6. 规则分层（Language-specific Rules）
**ECC做法**：`rules/common/`（通用）+ `rules/python/`（语言专用）

**我们的现状**：只有 `AGENTS.md` 统一规则

**行动**：
- [ ] 建立 `rules/common.md` — 通用开发规范
- [ ] 建立 `rules/typescript.md` — TypeScript 专用
- [ ] 建立 `rules/python.md` — Python 专用
- [ ] Skill 内引用规则时注明适用语言

#### 7. 验证循环（Verification Loops）
**ECC做法**：checkpoint vs continuous evals，pass@k 指标

**我们的现状**：任务做完直接结束，没有自验证

**行动**：
- [ ] 复杂任务设置「检查点」：完成一半时自我检查
- [ ] 建立「交付标准」：任务开始前明确什么叫「完成」
- [ ] 自验证后输出 summary，告知用户完成度

#### 8. 命令模式（Commands）
**ECC做法**：斜杠命令 `/plan`、`/tdd`、`/refactor` 快速触发技能

**我们的现状**：无命令系统，全靠对话

**行动**：
- [ ] 建立常用命令映射（如 `/自检` = 执行自检流程）
- [ ] 命令帮助文档：`/help commands`
- [ ] 命令可链式调用：`/自检 && /备份`

---

### 🟢 长期进化（持续进行）

#### 9. 安全规则体系
**ECC**：AgentShield，1282测试，102规则

**我们的差距**：几乎无安全规则

**行动**：
- [ ] 禁止在任务中执行 `rm -rf` 不确认
- [ ] 禁止删除非临时文件不确认
- [ ] 外部行动（发邮件/发推）必须 explicit 确认
- [ ] 建立安全规则文档 `rules/security.md`

#### 10. 多模型路由（Model Routing）
**ECC做法**：简单任务用轻量模型，节省成本

**现状限制**：OpenClaw 模型配置有限

**行动**：
- [ ] 探索 OpenClaw 模型路由可能性
- [ ] 识别「适合轻量模型」的任务类型
- [ ] 轻量任务用 MiniMax-M2，快且便宜

#### 11. MCP 精简化
**ECC经验**：200k上下文窗口，启用太多工具只剩70k

**我们的现状**：无 MCP 配置

**行动**：
- [ ] 盘点现有工具，识别低频工具
- [ ] 保持核心工具活跃，禁用低频工具
- [ ] 每次新加 MCP 前先问：真的需要吗？

---

## 三、具体执行计划

### 第一阶段（今天-明天）：基础设施
- [x] 建立 Skills 目录分层结构
- [ ] 创建 5 个核心子代理配置
- [ ] 实现会话结束自动记忆保存钩子

### 第二阶段（本周）：自动化
- [x] 实现 Pattern 自动提取机制
- [ ] 建立 Token 使用意识
- [ ] 命令映射系统

### 第三阶段（下周）：优化
- [ ] 规则分层
- [ ] 自验证循环
- [ ] 安全规则文档

### 第四阶段（持续）：进化
- [ ] 每月回顾 ECC 更新，吸收新功能
- [ ] 每次自检检查 Pattern 库，淘汰低置信度 Pattern
- [ ] 持续优化 Skills 结构

---

## 四、已吸收的具体改进

### 1. 技能目录重构
```
skills/
├── 自我管理/        # 自检、记忆、反省
│   ├── daily-check.md
│   ├── memory-consolidation.md
│   └── pattern-extractor.md
├── 任务执行/        # 搜索、抓取、执行
│   ├── web-search.md
│   ├── rss-reader.md
│   └── code-runner.md
├── 用户交互/        # 推送、提醒、问答
│   ├── feishu-sender.md
│   └── daily-summary.md
└── 系统维护/        # 备份、更新、健康检查
    ├── github-backup.md
    └── health-check.md
```

### 2. 子代理命名规范
- 主代理：`iris-main` — 只做编排和决策
- 记忆代理：`iris-memory` — 专门处理记忆相关
- 资讯代理：`iris-news` — 专门抓取和整理资讯
- 编码代理：`iris-coder` — 专门处理编程任务

### 3. Pattern 格式
```markdown
# Pattern: [名称]
- 场景：[什么时候用]
- 做法：[具体操作]
- 置信度：高/中/低
- 使用次数：N
- 上次使用：YYYY-MM-DD
```

---

_持续更新，每次吸收新东西后记录_