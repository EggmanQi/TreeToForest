//
//  EnvironmentalMessageView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct EnvironmentalMessageView: View {
    let onDismiss: () -> Void
    let onWater: () -> Void
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            // 背景色 #000000 (80% alpha)
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    // 点击背景不关闭，保持用户体验
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                // 背景A：标题和正文内容区域
                VStack(spacing: 0) {
                    // 标题
                    Text("A message for you")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 32)
                        .padding(.bottom, 24)
                    
                    // 正文内容
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Desertification is a serious environmental problem that affects the ecological balance of our planet. We need to take action to address this issue.")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("Join our APP and water the trees. Your participation will bring green and vitality to this land, contributing to global environmental protection.")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("We will plant your trees in the corresponding desert areas and name them after you. Through this small action, you have contributed your own strength to our home planet.")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
                .background(
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color(hex: "#CC8800"))
                )
                .padding(.horizontal, 16)
                .scaleEffect(isVisible ? 1.0 : 0.8)
                .opacity(isVisible ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.4), value: isVisible)
                
                // "I know it" 按钮 - 距离背景A底部24px
                Button(action: {
                    // 先执行收起动画
                    withAnimation(.easeIn(duration: 0.3)) {
                        isVisible = false
                    }
                    // 延迟执行关闭回调，等待动画完成
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onDismiss()
                    }
                }) {
                    Text("I know it")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(
                            RoundedRectangle(cornerRadius: 65/2)
                                .fill(Color(hex: "#FFAE0D"))
                        )
                }
                .padding(.top, 24)
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                .scaleEffect(isVisible ? 1.0 : 0.8)
                .opacity(isVisible ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.4).delay(0.1), value: isVisible)
                

                
                Spacer()
            }
        }
        .transition(.opacity.combined(with: .scale))
        .onAppear {
            // 触发显示动画
            withAnimation(.easeOut(duration: 0.4)) {
                isVisible = true
            }
        }
    }
}

#Preview {
    EnvironmentalMessageView(
        onDismiss: {},
        onWater: {}
    )
}
