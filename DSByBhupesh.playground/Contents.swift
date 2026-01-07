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

// 1️⃣ Find the Largest and Smallest Element in an Array without using predefined functions

let nums = [4, 7, 1, 9, 3]
var largest = nums[0]
var smallest = nums[0]
for num in nums {
    if num > largest {
        largest = num
    }
    if num < smallest {
        smallest = num
    }
}
print("Largest: \(largest), Smallest: \(smallest)")

// 2️⃣ Two pointer technique to reverse an array
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

// 3️⃣ Check if Array is Sorted
func isSorted(_ array: [Int]) -> Bool {
    for i in 1..<array.count {
        if array[i] < array[i - 1] {
            return false
        }
    }
    return true
}

// 4️⃣ Find Second Largest Element
func secondLargest(_ array: [Int]) {
    var largest = array[0]
    var second = array[0]
    
    for num in array {
        if num > largest {
            second = largest
            largest = num
        } else if num > second && num != largest {
            second = num
        }
    }
    print("Second Largest: \(second)")
}

secondLargest(nums)

// 5️⃣ Remove Duplicates from Sorted Array
func removeDuplicates(_ array: inout [Int]) -> Int {
    if array.isEmpty { return 0 }
    var uniqueIndex = 0
    for i in 1..<array.count {
        if array[i] != array[uniqueIndex] {
            uniqueIndex += 1
            array[uniqueIndex] = array[i]
        }
    }
    return uniqueIndex + 1
}

