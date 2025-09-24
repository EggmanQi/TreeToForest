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
    let canWater: Bool
    
    var body: some View {
        Button(action: {
            if canWater {
                onWater()
            } else {
                onDailyLimitTap()
            }
        }) {
            Text(canWater ? "Click to water" : "Daily limit reached")
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
        .padding(.horizontal, AppSpacing.lg)
        .padding(.bottom, AppSpacing.contentBottomPadding)
    }
}

#Preview {
    WaterButtonView(onWater: {}, onDailyLimitTap: {}, canWater: true)
}
