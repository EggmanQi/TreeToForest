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
                    .font(.custom("PingFang SC", size: 18, relativeTo: .body))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "#BD851F"))
                    )
                    .padding(.horizontal, 40)
            }
            .transition(.asymmetric(
                insertion: .scale(scale: 0.8).combined(with: .opacity),
                removal: .scale(scale: 0.8).combined(with: .opacity)
            ))
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isVisible)
            .onAppear {
                // 2秒后自动隐藏
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
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
