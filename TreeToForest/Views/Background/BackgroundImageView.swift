//
//  BackgroundImageView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image("bg_top")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                VStack {
                    Spacer()
                    Image("bg_bottom")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                Image("tree_lv_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, -100)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundImageView()
}
