//
//  DescriptionView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct DescriptionView: View {
    let waterTimes: Int
    
    var body: some View {
        VStack {
            // 主要说明文本
            Text(AppStrings.descriptionText)
                .font(AppFonts.body)
                .foregroundColor(AppColors.textWhite)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.md)
                .background(
                    RoundedRectangle(cornerRadius: AppSpacing.md)
                        .fill(AppColors.textWhite.opacity(0.3))
                )
                .padding(.horizontal, AppSpacing.md)
            
            // 浇水次数文本
            HStack {
                Text(AppStrings.dailyWateringTimes(current: waterTimes, max: GameConfig.maxWaterTimesPerDay))
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.textBrown)
                Spacer()
            }
            .padding(.horizontal, AppSpacing.lg)
        }
    }
}

#Preview {
    DescriptionView(waterTimes: 3)
        .background(.black)
}
