//: # MergeSort
var array = randomArray(length: 40, max: 100)
var arrayForDisplay = array

let arrayView = ArrayStackView()

// For display only. Not a part of merge sort.
func updateView(s: Int, l: Int, r: Int, e: Int) {
    // When 'l' and 'r' both surpase 'e', that means there are no remaining
    // elements to merge at in 'leftArr' and 'rightArr'
    arrayView.update(with: arrayForDisplay, [
        PointerLabel("s", s, .orange), // start index of mergedArr
        PointerLabel("l", l, .green), // start index of remaining left half, not in mergedArr
        PointerLabel("r", r, .cyan), // start index of remaining right half, not in mergedArr
        PointerLabel("e", e, .systemIndigo)]) // end index, inclusive
}

func merge<T: Comparable>(from start: Int, _ leftArr: [T], _ rightArr: [T]) -> [T] {
    var l = 0 // index in leftArr array
    var r = 0 // index in rightArr array
    var mergedArr: [T] = []
    
    while l < leftArr.count && r < rightArr.count {
        // Display Only --- Update after each element was appended
        let remainingLeft = Array(leftArr[l ..< leftArr.count])
        let remainingRight = Array(rightArr[r ..< rightArr.count])
        let newValues = mergedArr + remainingLeft + remainingRight
        arrayForDisplay.replace(newValues as! [Int], startingIndex: start)
        updateView(s: start,
                   l: start + mergedArr.count,
                   r: start + mergedArr.count + remainingLeft.count,
                   e: start + newValues.count - 1)
        // Display Only End ---
        
        let leftVal = leftArr[l]
        let rightVal = rightArr[r]
        
        if leftVal < rightVal {
            mergedArr.append(leftVal)
            l += 1
        } else if leftVal > rightVal {
            mergedArr.append(rightVal)
            r += 1
        } else {
            mergedArr.append(leftVal)
            l += 1
            mergedArr.append(rightVal)
            r += 1
        }
    }
    
    while l < leftArr.count {
        mergedArr.append(leftArr[l])
        l += 1
    }
    
    while r < rightArr.count {
        mergedArr.append(rightArr[r])
        r += 1
    }

    return mergedArr
}

// Note the 'start' param is used for display, not the algorithm.
func mergeSort(from start: Int, a: inout [Int]) {
    guard a.count > 1 else { return }
    
    let midIndex = a.count / 2
    var leftArr = Array(a[0 ..< midIndex])
    var rightArr = Array(a[midIndex ..< a.count])
    
    mergeSort(from: start, a: &leftArr)
    mergeSort(from: start + midIndex, a: &rightArr)
    
    a = merge(from: start, leftArr, rightArr)
    
    // Display Only --- Update after merge
    arrayForDisplay.replace(a, startingIndex: start)
    updateView(s: start,
               l: start + a.count,
               r: start + a.count,
               e: start + a.count - 1)
    // Display Only End ---
}

mergeSort(from: 0, a: &array)

assert(array == array.sorted())
