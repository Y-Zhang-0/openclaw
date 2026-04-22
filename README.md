# openclaw - Iris Coding Workspace

## 分支管理规则 / Branch Management

```
master     ← 生产环境，只接受 release 或 hotfix
develop    ← 开发主分支，所有功能合并到这里
feature/*  ← 功能分支，从 develop 创建
hotfix/*   ← 紧急修复，从 master 创建
```

## 工作流程

1. 新功能从 `develop` 创建 `feature/xxx` 分支
2. 开发完成后提 PR → 合并回 `develop`
3. `master` 需要更新时，从 `develop` 提 PR

