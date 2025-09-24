//
//  WaterAnimationConfig.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterAnimationConfig {
    // 动画尺寸 - 使用统一配置
    static let animationSize = AppSizes.animationSize
    
    // 动画容器尺寸（包含背景）
    static let containerSize = AppSizes.animationContainerSize
    
    // 帧率 - 保持24fps以获得流畅体验
    static let frameRate: TimeInterval = 1.0 / 24.0
    
    // 总帧数 - 保持50帧以获得细腻动画
    static let totalFrames = 50
    
    // 背景色（用于调试）
    static let debugBackgroundColor = Color.red.opacity(0.3)
    
    // 动画时长（秒）
    static var animationDuration: TimeInterval {
        return TimeInterval(totalFrames) * frameRate
    }
    
    // 图片缓存
    private static var imageCache: [String: Image] = [:]
    
    // 获取缓存的图片
    static func getCachedImage(for frame: Int) -> Image {
        let key = String(format: "%03d", frame)
        if let cached = imageCache[key] {
            return cached
        }
        let image = Image(key)
        imageCache[key] = image
        return image
    }
    
    // 预加载所有动画帧
    static func preloadAnimationFrames() {
        for frame in 0..<totalFrames {
            let key = String(format: "%03d", frame)
            if imageCache[key] == nil {
                imageCache[key] = Image(key)
            }
        }
    }
    
    // 获取动画位置（屏幕宽度的2/3处，垂直居中）
    static func getAnimationPosition() -> CGPoint {
        return AppPositions.getAnimationPosition()
    }
    
    // 获取屏幕中心位置（保留用于其他用途）
    static func getScreenCenterPosition() -> CGPoint {
        return AppPositions.getScreenCenterPosition()
    }
}
