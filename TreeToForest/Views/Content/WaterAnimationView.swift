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
    @State private var animationTask: Task<Void, Never>?
    
    private let totalFrames = WaterAnimationConfig.totalFrames
    private let frameRate = WaterAnimationConfig.frameRate
    
    var body: some View {
        Group {
            if isPlaying {
                WaterAnimationConfig.getCachedImage(for: currentFrameIndex)
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
        animationTask = Task {
            for frame in 0..<totalFrames {
                // 检查任务是否被取消
                if Task.isCancelled {
                    return
                }
                
                await MainActor.run {
                    currentFrameIndex = frame
                }
                
                // 等待下一帧
                try? await Task.sleep(nanoseconds: UInt64(frameRate * 1_000_000_000))
            }
            
            // 动画完成
            await MainActor.run {
                isPlaying = false
                onAnimationComplete()
            }
        }
    }
    
    private func stopAnimation() {
        animationTask?.cancel()
        animationTask = nil
    }
}

#Preview {
    WaterAnimationView(isPlaying: .constant(true), onAnimationComplete: {})
}
