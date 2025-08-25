//
//  DescriptionView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct DescriptionView: View {
    let waterTimes: Int
    let remainingWaterTimes: Int
    
    var body: some View {
        VStack(spacing: 20) {
            // 主要说明文本
            Text("When you plant a tree, we will plant a tree for you in the desert and name it after you!")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.3))
                )
                .padding(.horizontal, 24)
            
            // 浇水次数文本
            VStack(spacing: 8) {
                HStack {
                    Text("Today's watering times: \(waterTimes)/5")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.brown)
                    Spacer()
                }
                
                HStack {
                    Text("Remaining: \(remainingWaterTimes) times")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.brown.opacity(0.8))
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 40)
    }
}

#Preview {
    DescriptionView(waterTimes: 3, remainingWaterTimes: 2)
}
