//
//  ContentView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var waterTimes: Int = 5
    
    var body: some View {
        NavigationView {
            ZStack {
                // 确保完全覆盖的背景色
                Color.white
                    .ignoresSafeArea(.all)
                
                // 主要背景渐变层
                // 背景渐变层 (z=0)
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.694, blue: 0.443), // #FFB171
                        Color(red: 1.0, green: 0.886, blue: 0.686), // #FFE2AF
                        Color.white // #FFFFFF
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(.all)
                
                // 图片背景层 (z=1)
                GeometryReader { geometry in
                    ZStack {
                        // bg_bottom
                        VStack {
                            Spacer()
                            Image("bg_bottom")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        }
                        
                        // bg_top
                        VStack {
                            Image("bg_top")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                    }
                }
                
                VStack {
                    // 文本说明层 (z=2)
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
                        HStack {
                            Text("Today's watering times: \(waterTimes)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.brown)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Tree层 (z=3)
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Image("tree_lv_1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, geometry.size.height * 0.4) // bottom对齐bg_bottom的3/5高度处
                        }
                    }
                    
                    Spacer()
                    
                    // 按钮层 (z=4)
                    Button(action: {
                        waterTimes += 1
                    }) {
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
            .ignoresSafeArea()
            .navigationTitle("TTF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // 问号按钮点击事件
                    }) {
                        Image("icon_question")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
