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
                        // 触发浇水动画
                        isWaterAnimationPlaying = true
                        // 延迟执行实际的浇水逻辑，等待动画完成
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dataManager.incrementWaterTimes()
                        }
                    }, canWater: dataManager.canWater)
                }
                
                // 浇水动画层 (z=3，最上层)
                if isWaterAnimationPlaying {
                    WaterAnimationView(
                        isPlaying: $isWaterAnimationPlaying,
                        onAnimationComplete: {
                            // 动画完成后的回调
                            print("Water animation completed")
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
                            // 触发浇水动画
                            isWaterAnimationPlaying = true
                            // 延迟执行实际的浇水逻辑，等待动画完成
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                dataManager.incrementWaterTimes()
                            }
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
