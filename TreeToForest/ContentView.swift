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
                
                // 背景渐变层 (z=0)
                BackgroundGradientView()
                
                // 图片背景层 (z=1)
                BackgroundImageView()
                
                VStack {
                    // 文本说明层 (z=2)
                    DescriptionView(waterTimes: waterTimes)
                        .padding(.top, 80)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    WaterButtonView {
                        waterTimes += 1
                    }
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
