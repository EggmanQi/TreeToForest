//
//  WaterAnimationTestView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterAnimationTestView: View {
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Water Animation Test")
                .font(.title)
                .padding()
            
            WaterAnimationView(
                isPlaying: $isPlaying,
                onAnimationComplete: {
                    print("Animation test completed")
                }
            )
            .frame(width: 300, height: 300)
            .cornerRadius(15)
            
            Button("Play Animation") {
                isPlaying = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WaterAnimationTestView()
}
