# 启动屏幕配置实施计划

## 任务描述
将 launch.storyboard 设置为应用的启动屏幕文件，替换自动生成的启动屏幕。

## 当前状态分析

- ✅ 项目中已存在 `launch.storyboard` 文件
- ✅ launch.storyboard 包含树图标和白色背景
- ❌ 项目配置中启用了自动生成启动屏幕

## 实施步骤

### 1. 修改项目配置文件

- ✅ 将 `INFOPLIST_KEY_UILaunchScreen_Generation` 从 `YES` 改为 `NO`
- ✅ 添加 `INFOPLIST_KEY_UILaunchStoryboardName = launch` 配置
- ✅ 同时修改 Debug 和 Release 配置

### 2. 配置详情
**Debug 配置修改：**
```
INFOPLIST_KEY_UILaunchScreen_Generation = NO;
INFOPLIST_KEY_UILaunchStoryboardName = launch;
```

**Release 配置修改：**
```
INFOPLIST_KEY_UILaunchScreen_Generation = NO;
INFOPLIST_KEY_UILaunchStoryboardName = launch;
```

## launch.storyboard 内容

- 包含一个 ImageView，显示 `tree_lv_10` 图片
- 使用白色背景 (`systemBackgroundColor`)
- 图片居中显示，尺寸为 240x128
- 支持安全区域布局

## 技术实现细节

### 配置参数说明

- `INFOPLIST_KEY_UILaunchScreen_Generation = NO`：禁用自动生成启动屏幕
- `INFOPLIST_KEY_UILaunchStoryboardName = launch`：指定使用 launch.storyboard 作为启动屏幕

### 启动屏幕特性

- 启动屏幕会在应用启动时立即显示
- 当主界面加载完成后自动消失
- 提供平滑的启动体验

## 验证要点

1. ✅ 项目配置已正确修改
2. 🔄 需要重新编译项目验证效果
3. 🔄 在模拟器和真机上测试启动屏幕显示
4. 🔄 确认启动屏幕与 launch.storyboard 设计一致

## 完成状态
✅ 项目配置文件已修改
✅ Debug 和 Release 配置已同步更新
✅ 启动屏幕文件配置已完成

## 后续步骤

1. 在 Xcode 中重新编译项目
2. 在模拟器中测试启动屏幕效果
3. 如有需要，调整 launch.storyboard 的设计
