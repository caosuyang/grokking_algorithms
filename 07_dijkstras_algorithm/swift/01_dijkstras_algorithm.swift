import Foundation
// 狄克斯特拉算法

// 存储节点的所有邻居的散列表
// the graph
var graph =  [String : [String: Double]] ()
graph["start"] = [String: Double]()
// 获悉边的权重
graph["start"]?["a"] = 6
graph["start"]?["b"] = 2

// 添加其他节点及其邻居
graph["a"] = [String: Double]()
graph["a"]?["fin"] = 1

graph["b"] = [String: Double]()
graph["b"]?["a"] = 3
graph["b"]?["fin"] = 5

// 终点没有任何邻居
graph["fin"] = [String: Double]()

// 创建开销表
// the costs table
let infinity = Double.infinity
var costs = [String: Double]()
costs["a"] = 6
costs["b"] = 2
costs["fin"] = infinity

// 存储父节点的散列表
// the parents table
var parents = [String: String]()
parents["a"] = "start"
parents["b"] = "start"
parents["fin"] = nil

// 一个数组，用于记录处理过的节点
var processed = [String]()

// 找出开销最低的节点
func findLowestCostNode(costs: [String: Double]) -> [String: Double] {
    var lowestCost = Double.infinity
    var lowestCostNode = [String: Double]()
    // 遍历所有的节点
    // Go through each node.
    for node in costs {
        let cost = node.value
        // 如果当前节点的开销更低且未处理过
        // If it's the lowest cost so far and hasn't been processed yet...
        if (cost < lowestCost) && !processed.contains(node.key) {
            // 就将其赋值给开销最低的节点
            // ... set it as the new lowest-cost node.
            lowestCost = cost
            lowestCostNode = [node.key : node.value]
        }
        
    }
    return lowestCostNode
}

// 在未处理的节点中找出开销最小额节点
// Find the lowest-cost node that you haven't processed yet.
var node = findLowestCostNode(costs: costs)

// while在所有节点被处理后结束
// If you've processed all the nodes, this while loop is done.
while !node.isEmpty {
    // Swift Note: Unfortunately there are some limits for working with Dictionary inside Dictionary, so we have to use temp "nodeFirstKey" variable as workaround
    let nodeFirstKey = node.first?.key
    let cost = costs[nodeFirstKey!]
    // Go through all the neighbors of this node.
    let neighbors = graph[nodeFirstKey!]
    // 遍历当前节点的所有邻居
    for n in (neighbors?.keys)! {
        let newCost = cost! + (neighbors?[n])!
        // 如果经当前节点离该邻居更近
        // If it's cheaper to get to this neighbor by going through this node...
        if costs[n]! > newCost {
            // 就更新该邻居的开销
            // ... update the cost for this node.
            costs[n] = newCost
            // 同时将邻居的父节点设为当前节点
            // This node becomes the new parent for this neighbor.
            parents[n] = nodeFirstKey
        }
    }
    // 将当前节点标记为已处理过
    // Mark the node as processed.
    processed.append(nodeFirstKey!)
    // 找出接下来要处理的节点，并循环
    // Find the next node to process, and loop.
    node = findLowestCostNode(costs: costs)
}


print("Cost from the start to each node:")
print(costs) // -> ["b": 2.0, "fin": 6.0, "a": 5.0]

