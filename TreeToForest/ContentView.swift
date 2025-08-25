//
//  ContentView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var isWaterAnimationPlaying = false
    @State private var showEnvironmentalMessage = false
    @State private var isButtonVisible = true
    
    var body: some View {
        NavigationView {
            ZStack {
                // 确保完全覆盖的背景色
                Color.white
                    .ignoresSafeArea(.all)
                
                // 背景渐变层 (z=0)
                BackgroundGradientView()
                
                // 图片背景层 (z=1)
                BackgroundImageView(waterTimes: dataManager.waterTimes)
                
                VStack {
                    // 文本说明层 (z=2)
                    DescriptionView(waterTimes: dataManager.waterTimes, remainingWaterTimes: dataManager.remainingWaterTimes)
                        .padding(.top, 80)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    WaterButtonView(onWater: {
                        // 隐藏按钮并触发浇水动画
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isButtonVisible = false
                        }
                        isWaterAnimationPlaying = true
                    }, canWater: dataManager.canWater && isButtonVisible)
                }
                .offset(y: isButtonVisible ? 0 : 200) // 按钮向下移出屏幕
                
                // 浇水动画层 (z=3，最上层)
                if isWaterAnimationPlaying {
                    WaterAnimationView(
                        isPlaying: $isWaterAnimationPlaying,
                        onAnimationComplete: {
                            // 动画完成后的回调
                            print("Water animation completed")
                            // 执行浇水逻辑
                            dataManager.incrementWaterTimes()
                            // 重新显示按钮
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isButtonVisible = true
                            }
                        }
                    )
                    .position(WaterAnimationConfig.getAnimationPosition())
                    .onAppear {
                        let position = WaterAnimationConfig.getAnimationPosition()
                        print("Animation positioned at: (\(position.x), \(position.y))")
                    }
                }
                
                // 环境保护信息弹出层 (z=4，最上层)
                if showEnvironmentalMessage {
                    EnvironmentalMessageView(
                        onDismiss: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showEnvironmentalMessage = false
                            }
                        },
                        onWater: {
                            // 关闭弹出视图
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showEnvironmentalMessage = false
                            }
                            // 隐藏按钮并触发浇水动画
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isButtonVisible = false
                            }
                            isWaterAnimationPlaying = true
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .ignoresSafeArea()
            .navigationTitle("TTF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // 显示环境保护信息弹出视图
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showEnvironmentalMessage = true
                        }
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
