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
    
    // 从配置文件获取树等级
    private var treeLevel: Int {
        return configManager.getTreeLevel(for: waterTimes)
    }
    
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
                
                Image("tree_lv_\(treeLevel)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -80)
                    // .scaleEffect(isTreeBlinking ? 1.2 : 1.0) // 闪烁时稍微放大
                    .opacity(isTreeBlinking ? 0.3 : 1.0) // 闪烁时透明度变化
                    .animation(
                        isTreeBlinking ? 
                        .easeInOut(duration: 0.25).repeatCount(3, autoreverses: true) : 
                        .easeInOut(duration: 0.1),
                        value: isTreeBlinking
                    )
                    .onAppear {
                        // 重新加载配置
                        configManager.reloadConfig()
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
