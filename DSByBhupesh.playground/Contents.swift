import UIKit

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
 
 ## Two Pointers Pattern
 Used when array is sorted or when searching pairs.
 Template:
 
 var left = 0
 var right = nums.count - 1

 while left < right {
     // logic
     left += 1
     right -= 1
 }
 
 ## Sliding Window Pattern
 Used for subarray problems.
 Template:
 var left = 0
 var sum = 0

 for right in 0..<nums.count {
     sum += nums[right]

     while sum > target {   // shrink window
         sum -= nums[left]
         left += 1
     }
 }
 
 ##Prefix Sum
 Used for cumulative operations (subarray sum, ranges).
 Template:
 var prefix = Array(repeating: 0, count: nums.count + 1)
 for i in 0..<nums.count {
     prefix[i+1] = prefix[i] + nums[i]
 }
 // sum of subarray [l...r] = prefix[r+1] - prefix[l]
 
 ✔ Array memory model
 Stored in contiguous memory.
 Fast random access.
 Expanding array may require reallocation → reason for amortized cost.
 ✔ When to use arrays?
 Need fast indexing.
 Need fast traversal.
 When elements need ordering.
 ✔ When NOT to use arrays?
 When frequent insert/delete in middle is required → use Linked List.
 When ordering changes frequently.
 When size is unknown & memory tight → Dynamic arrays grow but cost when resizing.
 
 */

// 🔹 4. Must-Know Array Interview Questions (with Swift Snippets)
func reverseArray(_ arr: inout [Int]) {
    var l = 0, r = arr.count - 1
    while l < r {
        arr.swapAt(l, r)
        l += 1
        r -= 1
    }
   // print(arr)
}
var array1 = [1, 2, 5,7, 4, 3]
reverseArray(&array1)

func moveZeroes(_ nums: inout [Int]) {
    var slow = 0
    for fast in 0..<nums.count {
        if nums[fast] != 0 {
            nums.swapAt(slow, fast)
            slow += 1
        }
    }
    // print(nums)
}
 var array2 = [4,6,0,6,6,0,0,3,0,5]
moveZeroes(&array2)

// Remove duplicates from sorted array
func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.isEmpty { return 0 }

    var slow = 0
    for fast in 1..<nums.count {
        if nums[slow] != nums[fast] {
            slow += 1
            nums[slow] = nums[fast]
        }
    }
//    print(nums)
//    print(slow + 1)
    return slow + 1
}
var array3 = [4,6,6,6,6,7,7,8,8,9]
removeDuplicates(&array3)

// Rotate array by k steps
func rotate(_ nums: inout [Int], _ k: Int) {
    let k = k % nums.count
    reverse(&nums, 0, nums.count - 1)
    reverse(&nums, 0, k - 1)
    reverse(&nums, k, nums.count - 1)
}

func reverse(_ nums: inout [Int], _ l: Int, _ r: Int) {
    var l = l, r = r
    while l < r {
        nums.swapAt(l, r)
        l += 1
        r -= 1
    }
}

var array4 = [0,2,3,3,3,4]
// 7, 6, 5, 4, 3, 2, 1
// 5, 6, 7, 4, 3, 2, 1
// 5, 6, 7, 1, 2, 3, 4
// rotate(&array4, 3)

func majorityElement(_ nums: [Int]) -> Int {
    var count = 0
    var candidate = 0

    for num in nums {
        if count == 0 { candidate = num }
        count += (num == candidate ? 1 : -1)

    }
    return candidate
}
majorityElement(array4)

/////
///
/// Day 2
/// TWO POINTERS
/*
  wo pointers is one of the MOST used patterns in interviews.
Used when:
The array is sorted
You need to compare two ends
You want to shrink / expand a range
You want an O(n) solution instead of O(n²)
*/

func twoSumSorted(_ arr: [Int], _ target: Int) -> Bool {
    var left = 0
    var right = arr.count - 1

    while left < right {
        let sum = arr[left] + arr[right]

        if sum == target { return true }
        else if sum < target { left += 1 }
        else { right -= 1 }
    }
    return false
}
