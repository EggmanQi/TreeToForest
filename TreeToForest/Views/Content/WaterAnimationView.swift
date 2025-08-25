//
//  WaterAnimationView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterAnimationView: View {
    @Binding var isPlaying: Bool
    let onAnimationComplete: () -> Void
    
    @State private var currentFrameIndex = 0
    @State private var timer: Timer?
    
    private let totalFrames = WaterAnimationConfig.totalFrames
    private let frameRate = WaterAnimationConfig.frameRate
    
    var body: some View {
        Group {
            if isPlaying {
                Image("\(String(format: "%03d", currentFrameIndex))")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: WaterAnimationConfig.animationSize.width, height: WaterAnimationConfig.animationSize.height)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.1), value: currentFrameIndex)
                .onAppear {
                    startAnimation()
                }
                .onDisappear {
                    stopAnimation()
                }
            }
        }
    }
    
    private func startAnimation() {
        currentFrameIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
            withAnimation {
                if currentFrameIndex < totalFrames - 1 {
                    currentFrameIndex += 1
                } else {
                    stopAnimation()
                    isPlaying = false
                    onAnimationComplete()
                }
            }
        }
    }
    
    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    WaterAnimationView(isPlaying: .constant(true), onAnimationComplete: {})
}
