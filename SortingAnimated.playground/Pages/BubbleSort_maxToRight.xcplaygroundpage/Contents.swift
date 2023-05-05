/*:
 # Bubble sort
 
 A simple but ineffective sort with O(n^2) runtime.
 
 Given an array of N elements:
 * Iterate the array at most N - 1 times:
 * In each iteration, compare every pair of adjacent items.
 * If the left value is higher than the right, swap the values.
 
 Note that in the first iteration, the largest item will be in the last position.
 */
import Foundation
import UIKit

var array = randomArray(length: 14, max: 100)
let arrayView = ArrayStackView()

func updateView(_ arr: [Int], i: Int, j: Int, didSwap: Bool) {
    let border: UIColor? = didSwap ? .yellow: nil
    arrayView.update(
        with: arr,
        [PointerLabel("i", i, .orange),
         PointerLabel("j", j, .green, borderColor: border),
         PointerLabel("j+1", j+1, .green, borderColor: border)])
}

func bubbleSort(_ arr: inout [Int]) {
    guard !arr.isEmpty else {
        return
    }
    for i in 0 ..< arr.count - 1 { // How many to skip
        for j in 0 ..< arr.count - i - 1 {
            if (arr[j] > arr[j+1]) {
                arr.swapAt(j, j+1)
                // Swap so that arr[j+1] has the largest so far for this i.
                updateView(arr, i: i, j: j, didSwap: true)
            } else {
                updateView(arr, i: i, j: j, didSwap: false)
            }
        }
    }
}

bubbleSort(&array)

assert(array == array.sorted())
