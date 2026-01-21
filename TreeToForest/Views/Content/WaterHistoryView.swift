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
    
    // 选中的日记内容
    @State private var selectedJournalContent: String?
    @State private var showJournalDetail: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
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
                                    let hasJournal = dataManager.hasJournal(for: date)
                                    
                                    WaterHistoryCellView(date: date, count: count, hasJournal: hasJournal)
                                        .onTapGesture {
                                            if let content = dataManager.getJournal(for: date) {
                                                selectedJournalContent = content
                                                showJournalDetail = true
                                            }
                                        }
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
                
                // 日记详情弹窗
                if showJournalDetail, let content = selectedJournalContent {
                    JournalInputView(
                        isPresented: $showJournalDetail,
                        initialContent: content,
                        isReadOnly: true
                    )
                    .transition(.opacity.combined(with: .scale))
                    .zIndex(10)
                }
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
    
    // 过滤后的有效日期数组（降序，最新在前，仅包含有浇水或有日记的日期）
    private var allDates: [Date] {
        // 合并浇水记录和日记记录的日期
        let waterDates = Set(dataManager.waterHistory.keys)
        let journalDates = Set(dataManager.journalHistory.keys)
        let allRecordDates = waterDates.union(journalDates)
        
        guard !allRecordDates.isEmpty else {
            return []
        }
        
        var dates: [Date] = []
        for dateString in allRecordDates {
            if let date = dateFormatter.date(from: dateString) {
                dates.append(date)
            }
        }
        
        // 按日期降序排序
        return dates.sorted(by: >)
    }
}

#Preview {
    WaterHistoryView()
}

