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

// 6️⃣ Rotate Array by K Positions
func rotateArray(_ array: inout [Int], by k: Int) {
    let n = array.count
    let rotations = k % n
    array.reverse()
    array[0..<rotations].reverse()
    array[rotations..<n].reverse()
}

// 7️⃣ Find Missing Number (1 to N)
func findMissingNumber(_ array: [Int]) -> Int {
    let n = array.count + 1
    let expectedSum = n * (n + 1) / 2
    let actualSum = array.reduce(0, +)
    return expectedSum - actualSum
}
let arrWithMissing = [1, 2, 3, 5]
let missingNumber = findMissingNumber(arrWithMissing)

// 8️⃣ Move All Zeroes to End
func moveZeroesToEnd(_ array: inout [Int]) {
    var nonZeroIndex = 0
    for i in 0..<array.count {
        if array[i] != 0 {
            array[nonZeroIndex] = array[i]
            nonZeroIndex += 1
        }
    }
    while nonZeroIndex < array.count {
        array[nonZeroIndex] = 0
        nonZeroIndex += 1
    }
}

var arrayWithZeroes = [0, 1, 1, 4, 12, 1]
moveZeroesToEnd(&arrayWithZeroes)
print(arrayWithZeroes)

// 9️⃣ Find Maximum Subarray Sum (Kadane’s Algorithm)
func maxSubArraySum(_ array: [Int]) -> Int {
    var maxSoFar = array[0]
    var maxEndingHere = array[0]
    
    for i in 1..<array.count {
        maxEndingHere = max(array[i], maxEndingHere + array[i])
        maxSoFar = max(maxSoFar, maxEndingHere)
    }
    return maxSoFar
}
let subArray = [-2,1,-3,4,-1,2,1,-5,4]
let maxSum = maxSubArraySum(subArray)
print("Maximum Subarray Sum: \(maxSum)")

// 🔟 Find Two Sum
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var map = [Int: Int]()

    for (index, num) in nums.enumerated() {
        let complement = target - num
        if let i = map[complement] {
            return [i, index]
        }
        map[num] = index
    }
    return []
}

print(twoSum(subArray, 3))

