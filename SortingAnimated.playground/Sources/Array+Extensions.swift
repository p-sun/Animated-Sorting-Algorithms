import Foundation

extension MutableCollection where Index == Int {
    public mutating func swapAt(_ a: Int, _ b: Int) {
        Swift.swap(&self[a], &self[b])
    }
}

public func randomArray(count: Int, maxNumber: Int) -> [Int] {
    var array = [Int]()
    let minimumNumber = maxNumber / 30
    
    for _ in 1...count {
        let randomDiff = Int(arc4random_uniform(UInt32(maxNumber - minimumNumber)))
        
        array.append(minimumNumber + randomDiff)
    }
    
    return array
}
