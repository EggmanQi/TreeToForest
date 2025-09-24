//
//  ContentView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @StateObject private var dataManager = DataManager.shared
    @State private var isWaterAnimationPlaying = false
    @State private var showEnvironmentalMessage = false
    @State private var isButtonVisible = true
    @State private var showDailyLimitToast = false
    
    var body: some View {
        NavigationView {
            // 主要内容区域
            ZStack {
                // 确保完全覆盖的背景色
                Color.white
                    .ignoresSafeArea(.all)
                
                // 背景渐变层 (z=0)
                BackgroundGradientView()
            
                // 图片背景层 (z=1)
                BackgroundImageView(
                    waterTimes: dataManager.waterTimes, 
                    completeTrees: dataManager.completeTrees,
                    isTreeBlinking: dataManager.isTreeBlinking
                )
            
                VStack(spacing: 20) {
                    // 自定义导航栏
                    CustomNavigationBarView(
                        onQuestionTap: {
                            // 显示环境保护信息弹出视图
                            withAnimation(AppAnimations.easeInOut) {
                                showEnvironmentalMessage = true
                            }
                        },
                        onPrivacyTap: {
                            if let url = URL(string: AppConfig.privacyPolicyURL) {
                                openURL(url)
                            }
                        }
                    )
                    DescriptionView(waterTimes: dataManager.waterTimes)
                    Spacer()
                }
                .padding(.top, AppSpacing.contentTopPadding)
                
                VStack {
                    Spacer()
                    WaterButtonView(
                        onWater: {
                            // 隐藏按钮并触发浇水动画
                            withAnimation(AppAnimations.easeInOut) {
                                isButtonVisible = false
                            }
                            isWaterAnimationPlaying = true
                        },
                        onDailyLimitTap: {
                            // 显示每日限制提示
                            withAnimation(AppAnimations.easeInOut) {
                                showDailyLimitToast = true
                            }
                        },
                        canWater: dataManager.canWater && isButtonVisible
                    )
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
                            // 触发树闪烁动画
                            dataManager.triggerTreeBlinking()
                            // 重新显示按钮
                            withAnimation(AppAnimations.easeInOut) {
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
                            withAnimation(AppAnimations.easeInOut) {
                                showEnvironmentalMessage = false
                            }
                        },
                        onWater: {
                            // 关闭弹出视图
                            withAnimation(AppAnimations.easeInOut) {
                                showEnvironmentalMessage = false
                            }
                            // 隐藏按钮并触发浇水动画
                            withAnimation(AppAnimations.easeInOut) {
                                isButtonVisible = false
                            }
                            isWaterAnimationPlaying = true
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                DailyLimitToastView(isVisible: $showDailyLimitToast)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
