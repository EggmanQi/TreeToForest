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
    private let lastWaterDateKey = "lastWaterDate"
    private let completeTreesKey = "completeTrees"
    
    @Published var waterTimes: Int = 0
    @Published var completeTrees: [CompleteTree] = []
    private let maxWaterTimesPerDay = 5
    
    private init() {
        loadWaterTimes()
        loadCompleteTrees()
        checkAndResetDaily()
    }
    
    // 加载浇水次数
    private func loadWaterTimes() {
        waterTimes = userDefaults.integer(forKey: waterTimesKey)
    }
    
    // 保存浇水次数
    private func saveWaterTimes() {
        userDefaults.set(waterTimes, forKey: waterTimesKey)
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
    
    // 保存完成树数组
    private func saveCompleteTrees() {
        if let data = try? JSONEncoder().encode(completeTrees) {
            userDefaults.set(data, forKey: completeTreesKey)
        }
    }
    
    // 添加新的完成树
    private func addCompleteTree() {
        let newTree = CompleteTree(
            relativeX: Double.random(in: 0.1...0.9),
            relativeY: Double.random(in: 0.6...0.9), // 在屏幕下半部分
            size: Double.random(in: 20...50)
        )
        completeTrees.append(newTree)
        saveCompleteTrees()
    }
    
    // 获取当前日期字符串
    private func getCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    // 检查并重置每日数据
    private func checkAndResetDaily() {
        let currentDate = getCurrentDateString()
        let lastWaterDate = userDefaults.string(forKey: lastWaterDateKey) ?? ""
        
        // 如果是新的一天，重置浇水次数
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
        
        #if DEBUG
        // 调试环境下忽略每日限制
        waterTimes += 1
        saveWaterTimes()
        
        // 调试环境下每5次浇水就增加completeTrees
        if waterTimes % 5 == 0 {
            addCompleteTree()
        }
        #else
        // 生产环境下检查每日限制
        if waterTimes >= maxWaterTimesPerDay {
            return // 已达到每日限制，不增加
        }
        
        waterTimes += 1
        saveWaterTimes()
        
        // 检查是否达到50次，如果是则增加completeTrees
        if waterTimes == 50 {
            addCompleteTree()
        }
        #endif
        
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
        return max(0, maxWaterTimesPerDay - waterTimes)
    }
    
    // 检查是否还能浇水
    var canWater: Bool {
        #if DEBUG
        // 调试环境下始终允许浇水
        return true
        #else
        // 生产环境下检查每日限制
        return waterTimes < maxWaterTimesPerDay
        #endif
    }
}
