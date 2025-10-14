//
//  BackgroundImageView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct BackgroundImageView: View {
    let waterTimes: Int
    let completeTrees: [CompleteTree]
    let isTreeBlinking: Bool // 添加闪烁状态参数
    
    // 配置管理器
    @StateObject private var configManager = TreeConfigManager.shared
    
    // 等级动画状态
    @State private var currentLevel: Int = 1
    @State private var isLevelTransitioning: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image("bg_top")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                VStack {
                    Spacer()
                    Image("bg_bottom")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                // 显示完成的小树，使用持久化的位置信息
                ForEach(completeTrees) { tree in
                    Image("tree_lv_10")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: tree.size, height: tree.size)
                        .position(getActualPosition(for: tree, in: geometry))
                }
                
                Image("tree_lv_\(currentLevel)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -80)
                    // 等级切换与闪烁动画叠加
                    .scaleEffect(isLevelTransitioning ? 1.08 : 1.0)
                    .opacity(isTreeBlinking ? 0.3 : 1.0)
                    .animation(
                        isTreeBlinking ?
                            .easeInOut(duration: 0.25).repeatCount(3, autoreverses: true) :
                            .easeInOut(duration: 0.35),
                        value: isTreeBlinking
                    )
                    .onAppear {
                        // 重新加载配置
                        configManager.reloadConfig()
                        // 初始化当前等级
                        currentLevel = configManager.getTreeLevel(for: waterTimes)
                    }
                    .onChange(of: waterTimes) { newValue in
                        let configLevel = configManager.getTreeLevel(for: newValue)
                        // 规则：每逢5的倍数（含5）即触发“向下一个level”的转场动画
                        let maxLevel = 10
                        let targetLevel: Int = {
                            if newValue > 0 && newValue % 5 == 0 {
                                return min(configLevel + 1, maxLevel)
                            } else {
                                return configLevel
                            }
                        }()
                        
                        if targetLevel != currentLevel {
                            withAnimation(AppAnimations.easeOut) {
                                isLevelTransitioning = true
                                currentLevel = targetLevel
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation(AppAnimations.easeInOut) {
                                    isLevelTransitioning = false
                                }
                            }
                        }
                    }
            }
            .ignoresSafeArea()
        }
    }
    
    // 根据相对位置计算实际位置
    private func getActualPosition(for tree: CompleteTree, in geometry: GeometryProxy) -> CGPoint {
        let screenWidth = geometry.size.width
        let screenHeight = geometry.size.height
        
        let actualX = tree.relativeX * screenWidth
        let actualY = tree.relativeY * screenHeight
        
        return CGPoint(x: actualX, y: actualY)
    }
}

#Preview {
    BackgroundImageView(waterTimes: 3, completeTrees: [
        CompleteTree(relativeX: 0.3, relativeY: 0.7, size: 30),
        CompleteTree(relativeX: 0.7, relativeY: 0.8, size: 40)
    ], isTreeBlinking: false)
}
