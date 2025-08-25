//
//  NavigationBarView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct NavigationBarView: View {
    let onQuestionTap: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: onQuestionTap) {
                Image("icon_question")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavigationBarView(onQuestionTap: {})
}
