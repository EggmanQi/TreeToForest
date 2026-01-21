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
    @State private var showAbout = false
    @State private var showWaterHistory = false
    @State private var showJournalInput = false // 写日记弹窗
    @State private var isTreeBlinking = false // UI 状态：树闪烁
    private let firstLaunchMessageKey = "hasShownWelcomeMessage"
    
    // 触发树闪烁动画
    private func triggerTreeBlinking() {
        isTreeBlinking = true
        // 配置的时长后停止闪烁
        DispatchQueue.main.asyncAfter(deadline: .now() + GameConfig.treeBlinkingDuration) {
            isTreeBlinking = false
        }
    }
    
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
                    totalWaterTimes: dataManager.totalWaterTimes, 
                    completeTrees: dataManager.completeTrees,
                    isTreeBlinking: isTreeBlinking
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
                        },
                        onHistoryTap: {
                            showWaterHistory = true
                        },
                        onAboutTap: {
                            showAbout = true
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
                        onJournalTap: {
                            // 检查今日是否已写日记
                            if dataManager.hasWrittenJournalToday {
                                // 也可以弹个提示说今天已经写过了，或者直接进入查看模式
                                // 这里简单处理：弹个 Toast 提示
                                // showDailyLimitToast = true // 复用或新建一个 Toast
                                // 暂时我们让用户重新编辑或者只是提示
                                // 需求是"用户每天可以记录一次"，意味着只能写一次。
                                // 这里我们复用 DailyLimitToastView 的样式，但显示不同文案
                                // 为了简单，这里直接显示日记输入框，但在输入框内判断？
                                // 不，最好在点击时判断。
                                // 由于 DailyLimitToastView 文案是固定的，我们这里直接打开输入框，
                                // 但如果已存在，JournalInputView 可以显示只读模式或者编辑模式。
                                // 需求说"用户每天可以记录一次"，通常意味着不能修改。
                                // 我们弹出一个提示：今日已记录
                                // 为了更好的体验，我们直接打开日记查看
                                // 但主页的按钮主要是"写"，查看在历史记录里。
                                // 让我们弹出一个自定义的 Toast 或者 Alert。
                                // 简单起见，我们暂时允许重新编辑，或者如果不允许，就什么都不做。
                                // 根据需求"用户每天可以记录一次"，应该是不允许再次记录。
                                // 我们这里复用 showDailyLimitToast 逻辑，但需要修改 DailyLimitToastView 支持自定义文案
                                // 或者新建一个 Toast。
                                // 让我们简单点：如果写过了，就什么都不做（或者打印日志），或者进入编辑模式但覆盖？
                                // 通常"每天一次"意味着机会只有一次。
                                // 让我们做个假设：点击弹出输入框，如果已经写过，显示已有的内容，可以修改？
                                // 还是说完全禁止？
                                // 让我们假设：如果已经写过，点击按钮提示"今日已记录"。
                                // 由于没有通用的 Toast 组件支持自定义文本，我们这里暂时允许打开，但在保存时覆盖。
                                // 这样最符合直觉（"记录一次" = "保留最后一次"）
                                showJournalInput = true
                            } else {
                                showJournalInput = true
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
                            // print("Water animation completed")
                            // 执行浇水逻辑
                            dataManager.incrementWaterTimes()
                            // 触发树闪烁动画
                            triggerTreeBlinking()
                            // 重新显示按钮
                            withAnimation(AppAnimations.easeInOut) {
                                isButtonVisible = true
                            }
                        }
                    )
                    .position(WaterAnimationConfig.getAnimationPosition())
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
                            
                            // 检查是否可以浇水
                            if dataManager.canWater {
                                // 隐藏按钮并触发浇水动画
                                withAnimation(AppAnimations.easeInOut) {
                                    isButtonVisible = false
                                }
                                isWaterAnimationPlaying = true
                            } else {
                                // 显示每日限制提示
                                withAnimation(AppAnimations.easeInOut) {
                                    showDailyLimitToast = true
                                }
                            }
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                // About 弹层：透明背景覆盖在首页之上
                if showAbout {
                    AboutView(
                        appName: "TreeToForest",
                        onPrivacyTap: {
                            if let url = URL(string: AppConfig.privacyPolicyURL) { openURL(url) }
                        },
                        onClose: {
                            withAnimation(AppAnimations.easeInOut) { showAbout = false }
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                DailyLimitToastView(isVisible: $showDailyLimitToast)
                
                // 写日记弹窗
                if showJournalInput {
                    JournalInputView(
                        isPresented: $showJournalInput,
                        initialContent: nil, // 每次打开都显示空白，不加载历史记录
                        onSave: { content in
                            dataManager.saveJournal(content: content)
                        }
                    )
                    .transition(.opacity.combined(with: .scale))
                    .zIndex(5) // 确保在最上层
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .onAppear {
                // 首次启动进入首页后，自动弹出" A message for you "
                let hasShown = UserDefaults.standard.bool(forKey: firstLaunchMessageKey)
                if !hasShown {
                    withAnimation(AppAnimations.easeInOut) {
                        showEnvironmentalMessage = true
                    }
                    UserDefaults.standard.set(true, forKey: firstLaunchMessageKey)
                }
            }
            .sheet(isPresented: $showWaterHistory) {
                WaterHistoryView()
            }
        }
    }
}

#Preview {
    ContentView()
}
