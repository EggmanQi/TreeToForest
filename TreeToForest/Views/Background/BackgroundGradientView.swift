//
//  BackgroundGradientView.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
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
    }
}

#Preview {
    BackgroundGradientView()
}
