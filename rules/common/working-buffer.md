# Working Buffer — 工作缓冲区

> Proactive Agent WAL Protocol 的 Iris 实现
> 解决"context 压缩后丢失关键信息"的问题

## 问题

每次 context 压缩（compaction）时，可能丢失：
- 正在处理的复杂任务的中间状态
- 用户给的临时性偏好或约束
- 未完成的 multi-step 操作进度

## 解决：工作缓冲区

在每次复杂操作开始时，在 `memory/working-buffer/` 下创建文件记录状态。

### 格式
```
memory/working-buffer/{task-name}.md
```

### 内容
- 目标：最终要达成什么
- 当前进度：做到了哪一步
- 待继续：还需要做什么
- 风险：可能出现什么问题

### 示例
当用户让我"帮我查一下 X，然后总结 Y，最后发到飞书群"这种多步骤任务时：
1. 创建 `memory/working-buffer/multi-step-YYYYMMDD-HHMM.md`
2. 记录每一步的状态
3. 每完成一步更新状态
4. 全部完成后删除 buffer 文件

### 触发条件
- 任务超过 3 个步骤
- 任务预计会超过 10 分钟
- 任务中断风险高（跨天、依赖外部响应）

### 清理
任务完成后自动删除 buffer 文件，不积累。