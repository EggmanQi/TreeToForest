//
//  DataManager.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let waterTimesKey = "waterTimes"
    private let lastWaterDateKey = "lastWaterDate"
    
    @Published var waterTimes: Int = 0
    private let maxWaterTimesPerDay = 5
    
    private init() {
        loadWaterTimes()
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
        #else
        // 生产环境下检查每日限制
        if waterTimes >= maxWaterTimesPerDay {
            return // 已达到每日限制，不增加
        }
        
        waterTimes += 1
        saveWaterTimes()
        #endif
        
        // 更新最后浇水日期
        userDefaults.set(getCurrentDateString(), forKey: lastWaterDateKey)
    }
    
    // 重置浇水次数
    func resetWaterTimes() {
        waterTimes = 0
        saveWaterTimes()
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
