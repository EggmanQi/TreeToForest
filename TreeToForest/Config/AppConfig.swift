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
    // 树生成位置范围
    static let treeXRange = 0.1...0.9
    static let treeYRange = 0.6...0.9
    
    // 动画位置偏移
    static let animationPositionOffset = CGPoint(x: 0, y: 0)
    
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
