//: # Selection Sort (with minIndex)
import UIKit

var array = randomArray(length: 14, max: 100)
let arrayView = ArrayStackView()

func updateView(_ arr: [Int], _ i: Int, _ j: Int, _ minIndex: Int, shouldSwap: Bool) {
    let border: UIColor? = shouldSwap ? .yellow: nil
    arrayView.update(
        with: arr,
        [PointerLabel("i", i, .orange, borderColor: border),
         PointerLabel("j", j, .green),
         PointerLabel("min", minIndex, .blue, borderColor: border)])
}

func selectionSort(_ arr: inout [Int]) {
    guard !arr.isEmpty else {
        return
    }
    
    var minIndex: Int = arr[0]
    for i in 0..<arr.count {
        minIndex = i
        
        for j in i+1..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
            updateView(arr, i, j, minIndex, shouldSwap: false)
        }
        
        let shouldSwap = i != minIndex
        if shouldSwap  {
            // Fewer swaps than prev implementation of Selection Sort,
            // b/c we use minIndex, so we only need a max of n-1 swaps.
            arr.swapAt(i, minIndex)
        }
        updateView(arr, i, arr.count - 1, minIndex, shouldSwap: shouldSwap)
    }
}

selectionSort(&array)

assert(array == array.sorted())
