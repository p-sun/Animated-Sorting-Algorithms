// MergeSort

let arrayLength = 40
let maxNumber = 40
var array = randomArray(length: arrayLength, min: maxNumber / 30, max: maxNumber)

let arrayView = ArrayStackView()
arrayView.show()
arrayView.values = array

public func merge<T: Comparable>(from start: Int, _ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArray: [T] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            orderedArray.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            orderedArray.append(rightElement)
            rightIndex += 1
        } else {
            orderedArray.append(leftElement)
            leftIndex += 1
            orderedArray.append(rightElement)
            rightIndex += 1
        }
        
        // Update Method A - Update after each element was appended
        let remainingLeft = Array(left[leftIndex ..< left.count])
        let remainingRight = Array(right[rightIndex ..< right.count])
        let newValues = orderedArray + remainingLeft + remainingRight
        
        arrayView.insertValues(
            newValues: newValues as! [Int],
            startingFrom: start)
    }
    
    while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArray
}

// Note the 'start' param is used for display, not the algorithm.
func mergeSort(from start: Int, a: inout [Int]) {
    guard a.count > 1 else { return }
    
    let midIndex = a.count / 2
    var left = Array(a[0 ..< midIndex])
    var right = Array(a[midIndex ..< a.count])
    
    mergeSort(from: start, a: &left)
    mergeSort(from: start + midIndex, a: &right)
    
    a = merge(from: start, left, right)
    
    // Update Method B - Only update after merging two arrays
    // arrayView.insertValues(newValues: a, startingFrom: start)
}

mergeSort(from: 0, a: &array)

assert(array == array.sorted())
