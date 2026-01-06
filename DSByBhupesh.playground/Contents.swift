import UIKit

/// Data Structure Notes
// 🔹 1. Data Structure Time Complexities
/*
 Operation Array   Dictionary Set
 Access    O(1)    O(1)      O(1)
 Search    O(n)    O(1)      O(1)
 Insert    O(n)    O(1)      O(1)
 Delete    O(n)    O(1)      O(1)
 */


/*
 🔹 2. Array Operations & Complexity
 Operation    Complexity    Notes
 Access arr[i]    O(1)    Direct memory access
 Update arr[i] = x    O(1)    Constant time
 Append    O(1) amortized    Occasional resize
 Insert at index    O(n)    Shifts needed
 Remove(at index)    O(n)    Shifts needed
 Iteration    O(n)    Standard loop
 Search (unsorted)    O(n)    Linear
 Search (sorted)    O(log n) with binary search
*/

var arr = [1, 2, 3]
arr.append(4)        // O(1)
arr.insert(0, at: 0) // O(n)
arr.remove(at: 2)    // O(n)

// Two pointer technique to reverse an array
func reverseArray(_ array: inout [Int]) {
    var left = 0
    var right = array.count - 1
    while left < right {
        array.swapAt(left, right)
        left += 1
        right -= 1
    }
}
reverseArray(&arr)
