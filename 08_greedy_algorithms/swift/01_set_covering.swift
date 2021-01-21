import Foundation
// 贪婪算法

// 传入一个数组，被转换为集合
// You pass an array in, and it gets converted to a set.
var statesNeeded : Set = ["mt", "wa", "or", "id", "nv", "ut", "ca", "az"]

// 可供选择的广播台清单
var stations = [String: Set<String>]()
stations["kone"] = ["id", "nv", "ut"]
stations["ktwo"] = ["wa", "id", "mt"]
stations["kthree"] = ["or", "nv", "ca"]
stations["kfour"] = ["nv", "ut"]
stations["kfive"] = ["ca", "az"]

// 储存最终选择的广播台
var finalStations = Set<String>();

// 不断循环知道statesNeeded为空
while !statesNeeded.isEmpty {
    var bestStation = String()
    // 包含该广播台覆盖的所有未覆盖的州
    var statesCovered = Set<String>()
    
    // 循环迭代每个广播台，并确定是否是最佳广播台
    for station in stations {
        // 计算交集
        // 包含当前广播台覆盖的一系列还未覆盖的州
        let covered = statesNeeded.intersection(station.value)
        // 检查该广播台覆盖的州是否比bestStation多
        if covered.count > statesCovered.count {
            bestStation = station.key
            statesCovered = covered
        }
        // 更新statesNeeded
        statesNeeded = statesNeeded.subtracting(statesCovered)
        // 将bestStation添加到最终的广播台列表中
        //Swift note: We should avoid adding empty station to Set
        if !bestStation.isEmpty {
            finalStations.insert(bestStation)
        }
    }
}

print(finalStations) // -> ["kone", "kfive", "ktwo", "kthree"]


