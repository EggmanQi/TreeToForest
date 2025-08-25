//
//  BackgroundImageView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct BackgroundImageView: View {
    let waterTimes: Int
    
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
                
                Image("tree_lv_\(treeLevel)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -100)

                    .onAppear {
                        // 重新加载配置
                        configManager.reloadConfig()
                    }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundImageView(waterTimes: 3)
}
