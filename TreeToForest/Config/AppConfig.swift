//
//  AppConfig.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

// MARK: - 游戏配置
struct GameConfig {
    // 每日浇水限制
    static let maxWaterTimesPerDay = 5
    
    // 种植新树的阈值
    static let treeGenerationThreshold = 50
    
    // 树闪烁动画时长
    static let treeBlinkingDuration: TimeInterval = 1.5
    
    // 每日限制提示显示时长
    static let dailyLimitToastDuration: TimeInterval = 2.0
}

// MARK: - 应用配置
struct AppConfig {
    // 隐私政策链接
    static let privacyPolicyURL = "https://sites.google.com/view/treetoforest"
}

// MARK: - 颜色系统
struct AppColors {
    // 主色调
    static let primaryBlue = Color(hex: "#51B0FF")
    static let primaryBlueShadow = Color(hex: "#3E9BE7")
    
    // 警告色
    static let warningOrange = Color(hex: "#CC8800")
    static let warningYellow = Color(hex: "#FFAE0D")
    
    // 错误色
    static let errorBrown = Color(hex: "#BD851F")
    
    // 中性色
    static let disabledGray = Color.gray
    static let disabledGrayLight = Color.gray.opacity(0.7)
    
    // 背景色
    static let backgroundWhite = Color.white
    static let backgroundBlack = Color.black
    static let backgroundBlackOverlay = Color.black.opacity(0.8)
    
    // 文本色
    static let textWhite = Color.white
    static let textBrown = Color.brown
}

// MARK: - 间距系统
struct AppSpacing {
    // 基础间距
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 40
    
    // 特殊间距
    static let buttonHeight: CGFloat = 65
    static let buttonWidth: CGFloat = 212
    static let buttonCornerRadius: CGFloat = 25
    static let buttonShadowRadius: CGFloat = 6
    
    // 导航栏
    static let navigationBarHeight: CGFloat = 44
    static let navigationBarPadding: CGFloat = 16
    
    // 内容区域
    static let contentTopPadding: CGFloat = 40
    static let contentBottomPadding: CGFloat = 40
    static let contentHorizontalPadding: CGFloat = 16
}

// MARK: - 字体系统
struct AppFonts {
    // 标题
    static let title = Font.system(size: 24, weight: .bold)
    static let title2 = Font.system(size: 18, weight: .semibold)
    
    // 正文
    static let body = Font.system(size: 16, weight: .medium)
    static let bodyRegular = Font.system(size: 16)
    
    // 按钮
    static let button = Font.system(size: 18, weight: .semibold)
}

// MARK: - 文案系统
struct AppStrings {
    static let appName = "TreeToForest"
    
    // DescriptionView
    static let descriptionText = "当您种下一棵树，我们将为您在沙漠中种下一棵树，并以您的名字命名！"
    static func dailyWateringTimes(current: Int, max: Int) -> String {
        return "今日浇水次数: \(current)/\(max)"
    }
    
    // WaterButtonView
    static let clickToWater = "点击浇水"
    static let dailyLimitReached = "今日次数已达上限"
    
    // DailyLimitToastView
    static let dailyLimitToast = "浇水次数已用完，明天再来吧！"
    
    // EnvironmentalMessageView
    static let messageTitle = "致您的一封信"
    static let messageContent1 = "荒漠化是一个严重的环境问题，影响着我们星球的生态平衡。我们需要采取行动来解决这个问题。"
    static let messageContent2 = "加入我们的APP并为树木浇水。您的参与将为这片土地带来绿色和生机，为全球环境保护做出贡献。"
    static let messageContent3 = "我们将把您的树种在相应的沙漠地区，并以您的名字命名。通过这个小小的行动，您为我们的地球家园贡献了自己的力量。"
    static let iKnowIt = "我知道了"
    
    // AboutView
    static let aboutPrivacyPolicy = "隐私政策"
    
    // Journal
    static let journalButton = "日记"
    static let writeJournal = "写日记"
    static let journalPlaceholder = "请输入日记内容 (100字以内)"
    static let save = "保存"
    static let cancel = "取消"
    static let journalSavedToday = "今日已记录"
    static let viewJournal = "查看日记"
    static let noJournal = "暂无日记"
    static let journalContent = "日记内容"
}

// MARK: - 动画配置
struct AppAnimations {
    // 基础动画时长
    static let short: TimeInterval = 0.1
    static let medium: TimeInterval = 0.3
    static let long: TimeInterval = 0.4
    
    // 动画类型
    static let easeInOut = Animation.easeInOut(duration: medium)
    static let easeOut = Animation.easeOut(duration: long)
    static let spring = Animation.spring(response: 0.4, dampingFraction: 0.8)
}

// MARK: - 尺寸系统
struct AppSizes {
    // 图标尺寸
    static let iconSmall: CGFloat = 24
    static let iconMedium: CGFloat = 30
    static let iconLarge: CGFloat = 50
    
    // 树尺寸范围
    static let treeSizeMin: CGFloat = 20
    static let treeSizeMax: CGFloat = 50
    
    // 动画尺寸
    static let animationSize = CGSize(width: 200, height: 200)
    static let animationContainerSize = CGSize(width: 220, height: 220)
}

// MARK: - 位置配置
struct AppPositions {
    // 基础候选范围（先粗筛）
    static let treeXRange = 0.12...0.88
    static let treeYRange = 0.62...0.86
    
    // 动画位置偏移
    static let animationPositionOffset = CGPoint(x: 0, y: 0)
    
    // 生成一个避让"椭圆 + 按钮区"的安全位置（相对坐标 0~1）
    static func randomSafeTreePosition() -> (x: Double, y: Double) {
        // 椭圆（大坑）参数：可按视觉微调
        let cx = 0.50, cy = 0.44
        let rx = 0.30, ry = 0.10
        
        // 按钮禁区（底部中部）
        func inButtonZone(_ x: Double, _ y: Double) -> Bool {
            return y >= 0.84 && abs(x - 0.5) <= 0.22
        }
        
        // 椭圆禁区
        func inOval(_ x: Double, _ y: Double) -> Bool {
            let nx = (x - cx) / rx
            let ny = (y - cy) / ry
            return (nx * nx + ny * ny) < 1.0
        }
        
        // 简单拒绝采样
        for _ in 0..<50 {
            let x = Double.random(in: treeXRange)
            let y = Double.random(in: treeYRange)
            if !inButtonZone(x, y) && !inOval(x, y) {
                return (x, y)
            }
        }
        // 兜底：即便 50 次都撞禁区，也强行落点到范围中心附近
        return (0.5, 0.78)
    }

    // MARK: - 位置检测与投射（用于迁移旧数据，尽量小位移）
    private static func inButtonZone(_ x: Double, _ y: Double) -> Bool {
        return y >= 0.84 && abs(x - 0.5) <= 0.22
    }

    private static func inOval(_ x: Double, _ y: Double) -> Bool {
        let cx = 0.50, cy = 0.44
        let rx = 0.30, ry = 0.10
        let nx = (x - cx) / rx
        let ny = (y - cy) / ry
        return (nx * nx + ny * ny) < 1.0
    }

    // 将任意点投射到安全区域边界上，最小化位移
    static func projectToSafePosition(x: Double, y: Double) -> (x: Double, y: Double) {
        // 先裁剪到基础范围
        var px = min(max(x, treeXRange.lowerBound), treeXRange.upperBound)
        var py = min(max(y, treeYRange.lowerBound), treeYRange.upperBound)

        // 矩形按钮区：优先沿垂直方向上移到边界
        if inButtonZone(px, py) {
            py = 0.839 // 刚好在禁区上方一条线
        }

        // 椭圆区：沿从椭圆中心指向点的方向投射到椭圆外边界
        if inOval(px, py) {
            let cx = 0.50, cy = 0.44
            let rx = 0.30, ry = 0.10
            var dx = px - cx
            var dy = py - cy
            // 避免零向量
            if abs(dx) < 1e-6 && abs(dy) < 1e-6 {
                dx = 1e-6
            }
            // 计算当前点的椭圆归一化半径 r^2 = (dx/rx)^2 + (dy/ry)^2
            let r2 = (dx * dx) / (rx * rx) + (dy * dy) / (ry * ry)
            if r2 < 1.0 {
                // 需要把向量放大到边界上：scale = 1 / sqrt(r2)
                let scale = 1.0 / sqrt(r2)
                px = cx + dx * scale * 1.001 // 轻微超出，避免再次命中禁区
                py = cy + dy * scale * 1.001
            }
        }

        // 最终再次裁剪，确保在基础范围内
        px = min(max(px, treeXRange.lowerBound), treeXRange.upperBound)
        py = min(max(py, treeYRange.lowerBound), treeYRange.upperBound)
        return (px, py)
    }
    
    // 获取动画位置（屏幕宽度的2/3处，垂直居中）
    static func getAnimationPosition() -> CGPoint {
        let screenBounds = UIScreen.main.bounds
        return CGPoint(
            x: screenBounds.width * 2/3,
            y: screenBounds.height / 2
        )
    }
    
    // 获取屏幕中心位置
    static func getScreenCenterPosition() -> CGPoint {
        let screenBounds = UIScreen.main.bounds
        return CGPoint(
            x: screenBounds.width / 2 + animationPositionOffset.x,
            y: screenBounds.height / 2 + animationPositionOffset.y
        )
    }
}
