//
//  WaterButtonView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterButtonView: View {
    let onWater: () -> Void
    let onDailyLimitTap: () -> Void
    let onJournalTap: () -> Void // 新增日记回调
    let canWater: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // 浇水按钮
            Button(action: {
                if canWater {
                    onWater()
                } else {
                    onDailyLimitTap()
                }
            }) {
                Text(canWater ? AppStrings.clickToWater : AppStrings.dailyLimitReached)
                    .font(AppFonts.button)
                    .foregroundColor(AppColors.textWhite)
                    .frame(width: AppSpacing.buttonWidth, height: AppSpacing.buttonHeight)
                    .background(
                        RoundedRectangle(cornerRadius: AppSpacing.buttonCornerRadius)
                            .fill(
                                LinearGradient(
                                    colors: canWater ? [AppColors.primaryBlue, AppColors.primaryBlue] : [AppColors.disabledGray, AppColors.disabledGrayLight],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(
                                color: canWater ? AppColors.primaryBlueShadow : Color.clear,
                                radius: 0,
                                x: 0,
                                y: AppSpacing.buttonShadowRadius
                            )
                    )
            }
            
            // 日记按钮
            Button(action: onJournalTap) {
                VStack(spacing: 4) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 24))
                    Text(AppStrings.journalButton)
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(AppColors.primaryBlue)
                .frame(width: AppSpacing.buttonHeight, height: AppSpacing.buttonHeight) // 正方形
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
            }
        }
        .padding(.horizontal, AppSpacing.lg)
        .padding(.bottom, AppSpacing.contentBottomPadding)
    }
}

#Preview {
    WaterButtonView(onWater: {}, onDailyLimitTap: {}, onJournalTap: {}, canWater: true)
        .background(Color.gray)
}
