# TreeToForest 项目调整计划

本计划旨在解决代码审查中发现的核心逻辑冲突、交互漏洞及架构耦合问题，重点修复“树无法成长”的严重缺陷，并提升代码的可维护性。

## 阶段一：核心逻辑修复（高优先级）
**目标**：解决“每日重置导致树等级无法提升”的逻辑悖论，确保游戏核心循环正常闭环。

### 1. 数据模型重构 (`DataManager.swift`)
- **分离计数器**：
  - 保留 `waterTimes` 仅用于**每日限制**（每日重置）。
  - 新增 `totalWaterTimes` 用于**树木成长**与**成就统计**（永久累加，持久化存储）。
- **逻辑修正**：
  - `incrementWaterTimes()`：同时递增 `waterTimes` 和 `totalWaterTimes`。
  - `checkAndResetDaily()`：仅重置 `waterTimes`，保留 `totalWaterTimes`。
  - 新树生成判断：基于 `totalWaterTimes` 判断是否达到 50 次阈值（原逻辑因每日重置永远无法达成）。

### 2. 树等级与动画修正 (`BackgroundImageView.swift`)
- **数据源切换**：树等级计算 (`configManager.getTreeLevel`) 改为依赖 `totalWaterTimes`。
- **动画触发优化**：
  - 移除硬编码的 `newValue % 5 == 0` 判断。
  - 改为监听等级变化：`if newLevel > oldLevel { 触发升级动画 }`，确保与 `TreeConfig.plist` 配置完全一致。

## 阶段二：交互一致性修复（高优先级）
**目标**：堵住交互漏洞，确保所有浇水入口遵循统一规则。

### 1. 统一浇水限制 (`ContentView.swift`)
- **修复弹窗浇水漏洞**：
  - 在 `EnvironmentalMessageView` 的 `onWater` 回调中，增加 `dataManager.canWater` 检查。
  - 若已达每日上限，拦截操作并弹出 `DailyLimitToastView`，避免用户困惑。

## 阶段三：架构优化与代码清理（中优先级）
**目标**：降低模块耦合，提升代码可读性与规范性。

### 1. UI 状态解耦
- **移除 `DataManager` 中的 UI 状态**：
  - 将 `isTreeBlinking` 逻辑移出数据层。
  - 改为通过 `Combine` 事件流或回调机制通知 View 层播放动画，使 `DataManager` 专注业务数据。

### 2. 文案管理与清理
- **文案集中化**：将分散在各 View 的硬编码字符串（如提示语、按钮文字）提取到 `AppConfig` 或常量文件中，便于管理和汉化。
- **环境清理**：移除生产代码中的 `print` 调试日志。

## 阶段四：验证
- **测试用例**：
  1. 验证日期变更后，`waterTimes` 重置但 `totalWaterTimes` 保持。
  2. 验证连续浇水超过每日限制后，无法通过任何入口继续浇水。
  3. 验证累计浇水次数达到配置阈值时，树等级正确提升且动画触发。
