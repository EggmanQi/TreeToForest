//
//  WaterButtonView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterButtonView: View {
    let onWater: () -> Void
    
    var body: some View {
        Button(action: onWater) {
            Text("Click to water")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: [Color.blue, Color.cyan],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
}

#Preview {
    WaterButtonView(onWater: {})
}
