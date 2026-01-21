//
//  DataManager.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import Foundation
import CoreGraphics

// 完成树的数据结构
struct CompleteTree: Codable, Identifiable {
    let id: UUID
    let relativeX: Double // 相对X位置 (0-1)
    let relativeY: Double // 相对Y位置 (0-1)
    let size: Double // 树的大小
    
    init(relativeX: Double, relativeY: Double, size: Double) {
        self.id = UUID()
        self.relativeX = relativeX
        self.relativeY = relativeY
        self.size = size
    }
}

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let waterTimesKey = "waterTimes"
    private let totalWaterTimesKey = "totalWaterTimes"
    private let lastWaterDateKey = "lastWaterDate"
    private let completeTreesKey = "completeTrees"
    private let waterHistoryKey = "waterHistory"
    
    @Published var waterTimes: Int = 0
    @Published var totalWaterTimes: Int = 0
    @Published var completeTrees: [CompleteTree] = []
    @Published var waterHistory: [String: Int] = [:]
    @Published var journalHistory: [String: String] = [:]
    
    private let journalHistoryKey = "journalHistory"
    
    private init() {
        loadWaterTimes()
        loadTotalWaterTimes()
        loadCompleteTrees()
        loadWaterHistory()
        loadJournalHistory()
        checkAndResetDaily()
        migrateLegacyTreePositionsIfNeeded()
    }
    
    // 加载浇水次数
    private func loadWaterTimes() {
        waterTimes = userDefaults.integer(forKey: waterTimesKey)
    }
    
    // 加载累计浇水次数
    private func loadTotalWaterTimes() {
        totalWaterTimes = userDefaults.integer(forKey: totalWaterTimesKey)
        // 数据迁移：如果 total 为 0 但 waterTimes > 0，且没有历史 total 记录，初始化它
        // 注意：由于 waterTimes 每日重置，这个迁移只能找回“当天”的数据，但总比没有好
        if totalWaterTimes == 0 && waterTimes > 0 {
            totalWaterTimes = waterTimes
            saveTotalWaterTimes()
        }
    }
    
    // 保存浇水次数 - 异步保存以提升性能
    private func saveWaterTimes() {
        Task {
            await MainActor.run {
                userDefaults.set(waterTimes, forKey: waterTimesKey)
            }
        }
    }
    
    // 保存累计浇水次数
    private func saveTotalWaterTimes() {
        Task {
            await MainActor.run {
                userDefaults.set(totalWaterTimes, forKey: totalWaterTimesKey)
            }
        }
    }
    
    // 加载完成树数组
    private func loadCompleteTrees() {
        if let data = userDefaults.data(forKey: completeTreesKey),
           let trees = try? JSONDecoder().decode([CompleteTree].self, from: data) {
            completeTrees = trees
        } else {
            completeTrees = []
        }
    }
    
    // 保存完成树数组 - 异步保存以提升性能
    private func saveCompleteTrees() {
        Task {
            do {
                let data = try JSONEncoder().encode(completeTrees)
                await MainActor.run {
                    userDefaults.set(data, forKey: completeTreesKey)
                }
            } catch {
                print("Failed to save complete trees: \(error)")
            }
        }
    }
    
    // 加载浇水历史记录
    private func loadWaterHistory() {
        if let data = userDefaults.data(forKey: waterHistoryKey),
           let history = try? JSONDecoder().decode([String: Int].self, from: data) {
            waterHistory = history
        } else {
            waterHistory = [:]
        }
    }
    
    // 保存浇水历史记录 - 异步保存以提升性能
    private func saveWaterHistory() {
        Task {
            do {
                let data = try JSONEncoder().encode(waterHistory)
                await MainActor.run {
                    userDefaults.set(data, forKey: waterHistoryKey)
                }
            } catch {
                print("Failed to save water history: \(error)")
            }
        }
    }
    
    // 加载日记历史记录
    private func loadJournalHistory() {
        if let data = userDefaults.data(forKey: journalHistoryKey),
           let history = try? JSONDecoder().decode([String: String].self, from: data) {
            journalHistory = history
        } else {
            journalHistory = [:]
        }
    }
    
    // 保存日记历史记录 - 异步保存以提升性能
    private func saveJournalHistory() {
        Task {
            do {
                let data = try JSONEncoder().encode(journalHistory)
                await MainActor.run {
                    userDefaults.set(data, forKey: journalHistoryKey)
                }
            } catch {
                print("Failed to save journal history: \(error)")
            }
        }
    }
    
    // 保存日记
    func saveJournal(content: String, date: Date = Date()) {
        let dateString = getCurrentDateString(from: date)
        journalHistory[dateString] = content
        saveJournalHistory()
    }
    
    // 获取指定日期的日记
    func getJournal(for date: Date) -> String? {
        let dateString = getCurrentDateString(from: date)
        return journalHistory[dateString]
    }
    
    // 检查指定日期是否有日记
    func hasJournal(for date: Date) -> Bool {
        let dateString = getCurrentDateString(from: date)
        return journalHistory[dateString] != nil
    }
    
    // 检查今天是否已写日记
    var hasWrittenJournalToday: Bool {
        return hasJournal(for: Date())
    }
    
    
    // 添加新的完成树
    private func addCompleteTree() {
        let pos = AppPositions.randomSafeTreePosition()
        let newTree = CompleteTree(
            relativeX: pos.x,
            relativeY: pos.y,
            size: Double.random(in: AppSizes.treeSizeMin...AppSizes.treeSizeMax)
        )
        completeTrees.append(newTree)
        saveCompleteTrees()
    }

    // 一次性迁移：将历史树位置投射到新的安全区域（避免覆盖按钮/椭圆），仅运行一次
    private func migrateLegacyTreePositionsIfNeeded() {
        let migrationKey = "hasMigratedTreePositions_v1"
        if userDefaults.bool(forKey: migrationKey) { return }
        guard !completeTrees.isEmpty else {
            userDefaults.set(true, forKey: migrationKey)
            return
        }
        var changed = false
        var updated: [CompleteTree] = []
        updated.reserveCapacity(completeTrees.count)
        for t in completeTrees {
            let projected = AppPositions.projectToSafePosition(x: t.relativeX, y: t.relativeY)
            // 若位置发生变化则替换
            if abs(projected.x - t.relativeX) > 1e-6 || abs(projected.y - t.relativeY) > 1e-6 {
                changed = true
                updated.append(CompleteTree(relativeX: projected.x, relativeY: projected.y, size: t.size))
            } else {
                updated.append(t)
            }
        }
        if changed {
            completeTrees = updated
            saveCompleteTrees()
        }
        userDefaults.set(true, forKey: migrationKey)
    }
    
    // 获取当前日期字符串
    private func getCurrentDateString(from date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // 检查并重置每日数据
    func checkAndResetDaily() {
        let currentDate = getCurrentDateString()
        let lastWaterDate = userDefaults.string(forKey: lastWaterDateKey) ?? ""
        
        // 如果是新的一天，重置每日浇水次数 (但不重置 totalWaterTimes)
        if currentDate != lastWaterDate {
            waterTimes = 0
            saveWaterTimes()
            userDefaults.set(currentDate, forKey: lastWaterDateKey)
        }
    }
    
    // 增加浇水次数并保存
    func incrementWaterTimes() {
        // 检查是否是新的一天
        checkAndResetDaily()
        
        // 检查每日限制
        guard waterTimes < GameConfig.maxWaterTimesPerDay else {
            return // 已达到每日限制，不增加
        }
        
        // 增加每日次数
        waterTimes += 1
        saveWaterTimes()
        
        // 增加累计次数
        totalWaterTimes += 1
        saveTotalWaterTimes()
        
        // 同步更新历史记录
        let today = getCurrentDateString()
        waterHistory[today] = waterTimes
        saveWaterHistory()
        
        // 检查是否达到阈值，如果是则增加completeTrees
        // 使用累计次数判断，每满 treeGenerationThreshold 次生成一棵树
        if totalWaterTimes > 0 && totalWaterTimes % GameConfig.treeGenerationThreshold == 0 {
            addCompleteTree()
        }
        
        // 更新最后浇水日期
        userDefaults.set(getCurrentDateString(), forKey: lastWaterDateKey)
    }
    
    // 重置浇水次数
    func resetWaterTimes() {
        waterTimes = 0
        saveWaterTimes()
    }
    
    // 重置完成树数量
    func resetCompleteTrees() {
        completeTrees.removeAll()
        saveCompleteTrees()
    }
    
    // 获取剩余浇水次数
    var remainingWaterTimes: Int {
        return max(0, GameConfig.maxWaterTimesPerDay - waterTimes)
    }
    
    // 检查是否还能浇水
    var canWater: Bool {
        return waterTimes < GameConfig.maxWaterTimesPerDay
    }
}
