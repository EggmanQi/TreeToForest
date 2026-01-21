//
//  TreeConfigManager.swift
//  TreeToForest
//
//  Created by P on 2025/8/25.
//

import Foundation

struct TreeLevelConfig {
    let waterTimes: Int
    let treeLevel: Int
}

class TreeConfigManager: ObservableObject {
    static let shared = TreeConfigManager()
    
    private var treeLevels: [TreeLevelConfig] = []
    
    private init() {
        loadConfig()
    }
    
    // 加载配置文件
    private func loadConfig() {
        guard let path = Bundle.main.path(forResource: "TreeConfig", ofType: "plist"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
            print("Failed to load TreeConfig.plist")
            return
        }
        
        // 解析树等级配置
        if let treeLevelsArray = plist["treeLevels"] as? [[String: Any]] {
            treeLevels = treeLevelsArray.compactMap { dict in
                guard let waterTimes = dict["waterTimes"] as? Int,
                      let treeLevel = dict["treeLevel"] as? Int else {
                    return nil
                }
                return TreeLevelConfig(waterTimes: waterTimes, treeLevel: treeLevel)
            }.sorted { $0.waterTimes < $1.waterTimes }
        }
        
        // print("✅ TreeConfig loaded: \(treeLevels.count) levels")
    }
    
    // 根据浇水次数获取树等级
    func getTreeLevel(for waterTimes: Int) -> Int {
        // 找到小于等于当前浇水次数的最大配置
        let config = treeLevels.last { $0.waterTimes <= waterTimes }
        return config?.treeLevel ?? 1
    }
    

    
    // 重新加载配置（用于调试）
    func reloadConfig() {
        // 清除现有配置
        treeLevels.removeAll()
        // 重新加载
        loadConfig()
    }
    
    // 调试信息
    func debugInfo(for waterTimes: Int) {
        let treeLevel = getTreeLevel(for: waterTimes)
        
        print("WaterTimes: \(waterTimes)")
        print("Tree Level: \(treeLevel)")
    }
}
