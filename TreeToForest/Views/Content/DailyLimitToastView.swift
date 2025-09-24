//
//  DailyLimitToastView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct DailyLimitToastView: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            // 提示框
            VStack(spacing: 0) {
                Text("Watering times have been used up, come back tomorrow!")
                    .font(AppFonts.title2)
                    .foregroundColor(AppColors.textWhite)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.vertical, AppSpacing.md)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppColors.errorBrown)
                    )
                    .padding(.horizontal, AppSpacing.contentBottomPadding)
            }
            .transition(.asymmetric(
                insertion: .scale(scale: 0.8).combined(with: .opacity),
                removal: .scale(scale: 0.8).combined(with: .opacity)
            ))
            .animation(AppAnimations.spring, value: isVisible)
            .onAppear {
                // 配置的时长后自动隐藏
                DispatchQueue.main.asyncAfter(deadline: .now() + GameConfig.dailyLimitToastDuration) {
                    withAnimation(AppAnimations.spring) {
                        isVisible = false
                    }
                }
            }
        }
    }
}

#Preview {
    DailyLimitToastView(isVisible: .constant(true))
}
