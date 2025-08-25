//
//  WaterAnimationConfig.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterAnimationConfig {
    // 动画尺寸
    static let animationSize: CGSize = CGSize(width: 200, height: 200)
    
    // 动画容器尺寸（包含背景）
    static let containerSize: CGSize = CGSize(width: 220, height: 220)
    
    // 帧率
    static let frameRate: TimeInterval = 1.0 / 24.0
    
    // 总帧数
    static let totalFrames = 50
    
    // 背景色（用于调试）
    static let debugBackgroundColor = Color.red.opacity(0.3)
    
    // 动画位置（相对于屏幕中心）
    static let positionOffset = CGPoint(x: 0, y: 0)
    
    // 动画时长（秒）
    static var animationDuration: TimeInterval {
        return TimeInterval(totalFrames) * frameRate
    }
    
    // 获取动画位置（屏幕宽度的2/3处，垂直居中）
    static func getAnimationPosition() -> CGPoint {
        let screenBounds = UIScreen.main.bounds
        return CGPoint(
            x: screenBounds.width * 2/3,
            y: screenBounds.height / 2
        )
    }
    
    // 获取屏幕中心位置（保留用于其他用途）
    static func getScreenCenterPosition() -> CGPoint {
        let screenBounds = UIScreen.main.bounds
        return CGPoint(
            x: screenBounds.width / 2 + positionOffset.x,
            y: screenBounds.height / 2 + positionOffset.y
        )
    }
}
