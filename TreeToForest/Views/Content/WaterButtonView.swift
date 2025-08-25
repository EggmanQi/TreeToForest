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
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 212, height: 65)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: canWater ? [Color(hex: "#51B0FF"), Color(hex: "#51B0FF")] : [Color.gray, Color.gray.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(
                            color: canWater ? Color(hex: "#3E9BE7") : Color.clear,
                            radius: 0,
                            x: 0,
                            y: 6
                        )
                )
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
}

#Preview {
    WaterButtonView(onWater: {}, onDailyLimitTap: {}, canWater: true)
}
