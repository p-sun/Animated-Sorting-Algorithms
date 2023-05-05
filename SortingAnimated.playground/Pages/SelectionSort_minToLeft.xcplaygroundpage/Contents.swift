//: # Selection Sort
import Foundation
import UIKit

var array = randomArray(length: 14, max: 100)
let arrayView = ArrayStackView()

func updateView(_ arr: [Int], i: Int, j: Int, didSwap: Bool) {
    let border: UIColor? = didSwap ? .yellow: nil
    arrayView.update(
        with: arr,
        [PointerLabel("i", i, .orange, borderColor: border),
         PointerLabel("j", j, .green, borderColor: border)])
}

func selectionSort_slower(_ arr: inout [Int]) {
    guard !arr.isEmpty else {
        return
    }
    for i in 0..<arr.count {
        for j in i+1..<arr.count {
            if (arr[i] > arr[j]) {
                arr.swapAt(i, j)
                // Swap so that arr[i] has the smallest so far for this i.
                updateView(arr, i: i, j: j, didSwap: true)
            } else {
                updateView(arr, i: i, j: j, didSwap: false)
            }
        }
    }
}

selectionSort_slower(&array)

assert(array == array.sorted())
