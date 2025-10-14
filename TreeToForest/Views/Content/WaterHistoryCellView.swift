//
//  WaterHistoryCellView.swift
//  TreeToForest
//
//  Created by AI on 2025/10/13.
//

import SwiftUI

struct WaterHistoryCellView: View {
    let date: Date
    let count: Int
    
    var body: some View {
        VStack(spacing: 4) {
            // 日期标签（简化显示，如 "1/15"）
            Text(formattedDate)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            
            // 浇水状态格子
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(count > 0 ? "\(count)" : "")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                )
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: date)
    }
    
    private var backgroundColor: Color {
        count > 0 ? Color.green : Color.gray.opacity(0.2)
    }
}

#Preview {
    HStack(spacing: 10) {
        WaterHistoryCellView(date: Date(), count: 0)
        WaterHistoryCellView(date: Date(), count: 3)
        WaterHistoryCellView(date: Date(), count: 10)
    }
    .padding()
}

