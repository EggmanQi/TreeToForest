//
//  NavigationBarView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct NavigationBarView: View {
    let onQuestionTap: () -> Void
    let onPrivationTap: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: onQuestionTap) {
                Image("返回 1")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Button(action: onPrivationTap) {
                Image("返回 2")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationBarView(onQuestionTap: {}, onPrivationTap: {}).background(.red)
}

