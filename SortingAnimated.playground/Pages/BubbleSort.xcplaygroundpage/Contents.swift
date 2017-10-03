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

var array = randomArray(length: 40, max: 100)
let arrayView = ArrayStackView()

var isSorted: Bool

repeat {
    isSorted = true

    // Check each value in the array
    for i in 0..<array.count - 1 {

        // Compare current value to the next
        if array[i] > array[i + 1] {

            // Swap if needed
            array.swapAt(i, i + 1)
            arrayView.update(with: array)
            isSorted = false
        }
    }
} while (!isSorted)

assert(array == array.sorted())
