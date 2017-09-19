// QuickSort

let arrayLength = 180
let maxNumber = 10000
var array = randomArray(length: arrayLength, min: maxNumber / 30, max: maxNumber)

let arrayView = ArrayStackView()
arrayView.show()
arrayView.values = array

// Quick sort a subarray from index start...end
func quickSort(_ array: inout [Int], start: Int, end: Int) {
    guard start < end else { return }
    
    let pivotIndex = (start + end) / 2 // TODO Randomize the partition
    let pivotElement = array[pivotIndex]
    
    let p = partition(&array, start: start, end: end, pivot: pivotElement)
    quickSort(&array, start: start, end: p)
    quickSort(&array, start: p + 1, end: end)
}

/// The array is partitioned into [start...p] and [p+1...end]
/// All elements in the left array <= the pivot.
/// All elements in the right array > the pivot.
/// Return p, the end index of the left array.
/// Note this may not be the pivot's index.
func partition(_ a: inout [Int], start: Int, end: Int, pivot: Int) -> Int {
    var i = start - 1
    var j = end + 1
    
    while true {
        repeat { i += 1 } while a[i] < pivot
        repeat { j -= 1 } while a[j] > pivot
        
        if i < j {
            a.swapAt(i, j)
            arrayView.values = a
        } else {
            return j
        }
    }
}

quickSort(&array, start: 0, end: array.count - 1)

assert(array == array.sorted())
