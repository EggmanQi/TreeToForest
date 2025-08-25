//
//  TreeView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct TreeView: View {
    var body: some View {
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
    }
}

#Preview {
    TreeView()
}
