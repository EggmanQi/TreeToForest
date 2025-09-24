//
//  TreeToForestApp.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

@main
struct TreeToForestApp: App {
    init() {
        // 预加载动画帧以提升性能
        WaterAnimationConfig.preloadAnimationFrames()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
