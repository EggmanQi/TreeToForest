//
//  ContentView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                // 确保完全覆盖的背景色
                Color.white
                    .ignoresSafeArea(.all)
                
                // 背景渐变层 (z=0)
                BackgroundGradientView()
                
                // 图片背景层 (z=1)
                BackgroundImageView()
                
                VStack {
                    // 文本说明层 (z=2)
                    DescriptionView(waterTimes: dataManager.waterTimes, remainingWaterTimes: dataManager.remainingWaterTimes)
                        .padding(.top, 80)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    WaterButtonView(onWater: {
                        dataManager.incrementWaterTimes()
                    }, canWater: dataManager.canWater)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("TTF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // 问号按钮点击事件
                    }) {
                        Image("icon_question")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
