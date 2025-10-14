//
//  WaterHistoryView.swift
//  TreeToForest
//
//  Created by AI on 2025/10/13.
//

import SwiftUI

struct WaterHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 热力图网格
                    if !allDates.isEmpty {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 7),
                            spacing: 8
                        ) {
                            ForEach(allDates, id: \.self) { date in
                                let dateString = dateFormatter.string(from: date)
                                let count = dataManager.waterHistory[dateString] ?? 0
                                WaterHistoryCellView(date: date, count: count)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        // 底部起始日期
                        if let firstDate = allDates.last {
                            Text("Start date: \(displayDateFormatter.string(from: firstDate))")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .padding(.top, 20)
                                .padding(.bottom, 30)
                        }
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No records")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                    }
                }
                .padding(.top, 20)
            }
            .navigationTitle("Records")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // 日期格式化器（用于存储key匹配）
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    // 显示日期格式化器
    private var displayDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    // 生成从第一条记录到今天的连续日期数组（降序，最新在前）
    private var allDates: [Date] {
        guard !dataManager.waterHistory.isEmpty else {
            return []
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // 找到最早的记录日期
        let dateStrings = dataManager.waterHistory.keys
        var earliestDate = today
        
        for dateString in dateStrings {
            if let date = dateFormatter.date(from: dateString) {
                if date < earliestDate {
                    earliestDate = date
                }
            }
        }
        
        // 生成从最早日期到今天的所有日期
        var dates: [Date] = []
        var currentDate = today
        
        while currentDate >= earliestDate {
            dates.append(currentDate)
            if let previousDate = calendar.date(byAdding: .day, value: -1, to: currentDate) {
                currentDate = previousDate
            } else {
                break
            }
        }
        
        return dates
    }
}

#Preview {
    WaterHistoryView()
}

