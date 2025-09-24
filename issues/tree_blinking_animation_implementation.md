# 树闪烁动画实施计划

## 任务描述
在浇水动画完成后，为背景图片中的树添加闪烁动画效果，增强用户体验。

## 实施步骤

### 1. 修改 DataManager.swift
- ✅ 添加 `@Published var isTreeBlinking: Bool = false` 状态
- ✅ 添加 `triggerTreeBlinking()` 方法，设置闪烁状态并在1.5秒后自动停止

### 2. 修改 BackgroundImageView.swift
- ✅ 添加 `isTreeBlinking: Bool` 参数
- ✅ 为当前等级的树添加闪烁动画效果：
  - 缩放效果：闪烁时放大到1.1倍
  - 透明度效果：闪烁时透明度变为0.7
  - 动画配置：重复3次，每次0.3秒，自动反转

### 3. 修改 ContentView.swift
- ✅ 传递 `isTreeBlinking` 状态给 BackgroundImageView
- ✅ 在浇水动画完成回调中调用 `dataManager.triggerTreeBlinking()`

## 技术实现细节

### 闪烁动画配置
- 持续时间：1.5秒
- 闪烁次数：3次
- 动画类型：缩放 + 透明度变化
- 动画曲线：easeInOut

### 状态管理
- 使用 `@Published` 属性包装器实现响应式更新
- 通过 DataManager 统一管理闪烁状态
- 自动清理机制确保状态正确重置

## 测试要点
1. 浇水动画完成后树是否正常闪烁
2. 闪烁动画是否在1.5秒后自动停止
3. 多次浇水时闪烁动画是否正常工作
4. 动画效果是否流畅自然

## 完成状态
✅ 所有修改已完成
✅ 代码已通过语法检查
✅ 功能已集成到现有架构中
