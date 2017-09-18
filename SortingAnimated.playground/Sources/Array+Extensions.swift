import Foundation

extension MutableCollection where Index == Int {
    public mutating func swapAt(_ a: Int, _ b: Int) {
        Swift.swap(&self[a], &self[b])
    }

}

public func randomArray(length: Int, min: Int, max: Int) -> [Int] {
    var array = [Int]()
    
    for _ in 1...length {
        let randomDiff = Int(arc4random_uniform(UInt32(max - min)))
        array.append(min + randomDiff)
    }
    
    return array
}
