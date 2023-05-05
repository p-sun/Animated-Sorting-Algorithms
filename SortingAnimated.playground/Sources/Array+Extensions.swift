import Foundation

public func randomArray(length: Int, max: Int) -> [Int] {
    var array = [Int]()
    
    let min = max / 30
    for _ in 1...length {
        let randomDiff = Int(arc4random_uniform(UInt32(max - min)))
        array.append(min + randomDiff)
    }
    
    return array
}

public extension Array where Iterator.Element == Int {
    mutating func replace(_ newValues: [Int], startingIndex: Int) {
        let newSubRange = startingIndex..<(startingIndex + newValues.count)
        self.replaceSubrange(newSubRange, with: newValues)
    }
}
