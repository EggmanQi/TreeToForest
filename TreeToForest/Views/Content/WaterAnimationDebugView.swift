//
//  WaterAnimationDebugView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct WaterAnimationDebugView: View {
    @State private var isPlaying = false
    @State private var animationFrame: CGRect = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text("Water Animation Debug View")
                    .font(.title)
                    .padding()
                
                Text("Screen Size: \(Int(geometry.size.width)) × \(Int(geometry.size.height))")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ZStack {
                    // 屏幕中心指示器
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    // 2/3宽度位置指示器
                    Circle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .position(x: geometry.size.width * 2/3, y: geometry.size.height / 2)
                    
                    // 动画容器
                    WaterAnimationView(
                        isPlaying: $isPlaying,
                        onAnimationComplete: {
                            print("Animation debug completed")
                        }
                    )
                    .background(
                        GeometryReader { animationGeometry in
                            Color.clear
                                .onAppear {
                                    animationFrame = animationGeometry.frame(in: .global)
                                }
                                .onChange(of: animationGeometry.frame(in: .global)) { newFrame in
                                    animationFrame = newFrame
                                }
                        }
                    )
                }
                .frame(width: 300, height: 300)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .border(Color.blue, width: 1)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Animation Position:")
                        .font(.headline)
                    Text("X: \(Int(animationFrame.minX))")
                    Text("Y: \(Int(animationFrame.minY))")
                    Text("Width: \(Int(animationFrame.width))")
                    Text("Height: \(Int(animationFrame.height))")
                }
                .font(.caption)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
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
}

#Preview {
    WaterAnimationDebugView()
}
