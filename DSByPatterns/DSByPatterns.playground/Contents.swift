import UIKit

// 🔥 PATTERN 1: Sliding Window (10 Questions)
// The sliding window technique optimizes array/string problems by converting nested loops (O(n²)) into a single loop (O(n)).
// Pseudo Code:

// 1️⃣ Maximum Sum of Subarray of Size K
// This is a fixed window problem, here we don't have to make/shir the left pointer
//  We just have to slide the window by 1 position to the right until we reach the end of the array.

func maximumSum(arr: [Int], k: Int) -> Int {
    guard arr.count >= k && k > 0 else { return 0 }
    
    var currentSum = 0
    var maxSum = currentSum

    // 1. Calculate sum of the first window of size K
    for i in 0..<k {
        currentSum += arr[i]
    }
    
    // 2. Slide the window from index K to the end of the array
    for i in k..<arr.count {
        // Subtract the element going out of the window and add the new element
        currentSum += arr[i] - arr[i - k]
        // Update maxSum if currentSum is greater
        maxSum = max(maxSum, currentSum)
    }
    
    return maxSum
}

maximumSum(arr: [2,1,5,1,3,2], k: 3) // 9

// 2️⃣ Longest Substring Without Repeating Characters
// This is a dynamic window problem, here we have to adjust the left pointer based on the condition of repeating characters.
// Pseudo Code:
// Take on left pointer at the start of the string
// Iterate with right pointer through the string
// Hashmap to store the last seen index of each character, If character is already in the hashmap and its index is greater than or equal to left pointer, move the left pointer to index + 1 of that character
// Calculate the length of the current window and update max length if needed
func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count <= 1 {
        return s.count
    }
    var left = 0
    var hashMap: [Character: Int] = [:]
    let charArray = Array(s)
    var maxLength = 0
    for (right, charr) in charArray.enumerated() {
        if let lastSeenIndex = hashMap[charr], lastSeenIndex >= left {
            left = lastSeenIndex + 1
        }
        maxLength = max(maxLength, right - left + 1)
        hashMap[charr] = right
    }
    return maxLength
}
        
lengthOfLongestSubstring("abcabcbb") // 3

// 3️⃣ Minimum Size of Subarray which Sum equals/greater to K
// This is a dynamic window problem, here we have to adjust the left pointer based on the condition of sum of the window.
// Pseudo Code:
// Take on left pointer at the start of the array
// Iterate with right pointer through the array and keep adding the elements to the current sum
// If current sum is greater than or equal to K, update the minimum length and move the left pointer to the right until the current sum is less than K, while updating the minimum length

func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var minLength = Int.max
    var currentSum = 0
    var left = 0
    
    for right in 0..<nums.count {
        // 1. Expand the window
        currentSum += nums[right]
        
        // 2. Shrink the window as long as the sum is >= target
        while currentSum >= target {
            minLength = min(minLength, right - left + 1)
            currentSum -= nums[left]
            left += 1 // 1
        }
    }
    
    // 3. If no such subarray was found, return 0
    return minLength == Int.max ? 0 : minLength
}

minSubArrayLen(7, [2,3,1,2,4,3]) // 2


//4️⃣ Longest Repeating Character Replacement
// The Formula: replacements_needed = (window_size) - (count of most frequent character in window)
//    Pseudo Code:
//    Take on left pointer at the start of the string
//    Iterate with right pointer through the string and keep track of the frequency of characters in the current window using a hashmap
//    Keep track of the count of the most frequent character in the current window
//    If the number of replacements needed is greater than K, move the left pointer to the right until the number of replacements needed is less than or equal to K, while updating the frequency of characters and the count of the most frequent character

func characterReplacement(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var freq = [Character: Int]()
    var left = 0, maxFreq = 0, res = 0

    for right in 0..<chars.count {
        freq[chars[right], default: 0] += 1
        maxFreq = max(maxFreq, freq[chars[right]]!)

        if (right - left + 1) - maxFreq > k {
            freq[chars[left]]! -= 1
            left += 1
        }
        res = max(res, right - left + 1)
    }
    return res
}
characterReplacement("AABABBA", 1) // 4
characterReplacement("ABAB", 2) // 4
characterReplacement("AABABBA", 2) // 5

//  Max Consecutive Ones III
/*
 Pseudo Code:
    Take on left pointer at the start of the array
    Iterate with right pointer through the array and keep track of the number of zeros in the current window
    If the number of zeros is greater than K, move the left pointer to the right until the number of zeros is less than or equal to K, while updating the count of zeros
    Calculate the length of the current window and update max length if needed
 */

func longestOnes(_ nums: [Int], _ k: Int) -> Int {
    var left = 0
    var zeroCount = 0
    var maxLength = 0
    
    for right in 0..<nums.count {
        if nums[right] == 0 {
            zeroCount += 1
        }
        
        while zeroCount > k {
            if nums[left] == 0 {
                zeroCount -= 1
            }
            left += 1
        }
        
        maxLength = max(maxLength, right - left + 1)
        
    }
    
    return maxLength
}

// 🔥 PATTERN 2: Two Pointers (10 Questions)

// 1️⃣ Two Sum (Sorted Array)

// Pseudo Code:
// Take two pointers, one at the start of the array and another at the end of the array
// Calculate the sum of the elements at the two pointers
// If the sum is equal to the target, return the indices of the two pointers
// If the sum is less than the target, move the left pointer to the right
// If the sum is greater than the target, move the right pointer to the left
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var left = 0
    var right = numbers.count - 1
    
    while left < right {
        let sum = numbers[left] + numbers[right]
        
        if sum == target {
            return [left, right]
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    return [] // Return empty array if no solution is found
}
    

// 2️⃣ Reverse String

// Pseudo code:
// Convert srring to an array of characters
// Use two pointer appoach, one pointer at the start of the array and another at the end of the array
// Swap the characters at the two pointers and move the pointers towards each other until they meet
func reverseString(_ s: inout [Character]) {
    var left = 0
    var right = s.count - 1
    
    while left < right {
        s.swapAt(left, right)
        left += 1
        right -= 1
    }
}

// 3️⃣ Valid Palindrome
// Pseudo Code:
// Take two pointers, one at the start of the string and another at the end of the string
// Move the pointers towards each other until they meet, comparing the characters at the two pointers
// If the characters are not equal, return false
// If the pointers meet, return true

func isPalindrome(_ s: String) -> Bool {
    var chars = Array(s.lowercased())
    var left  = 0
    var right = chars.count - 1
    
    while left < right {
        if chars[left] != chars[right] {
            return false
        }
        left += 1
        right -= 1
    }
    return true
}

// 4️⃣ Remove Duplicates from Sorted Array
// This solution uses a two-pointer technique to solve the problem efficiently in-place with O(1) extra space.
// Slow pointer , fast pointer technique
// Pseudo Code:
// Take two pointers, one slow pointer at the start of the array and another fast pointer at the second element of the array
// Iterate with the fast pointer through the array, comparing the elements at the slow and fast pointers
// If the elements are not equal, move the slow pointer to the right and update the element at the slow pointer with the element at the fast pointer
// If the elements are equal, move the fast pointer to the right
// Return the length of the array
func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.isEmpty { return 0 }
    
    var slow = 0 // Unique elements index
    
    for fast in 1..<nums.count {
        if nums[slow] != nums[fast] {
            slow += 1
            nums[slow] = nums[fast]
        }
    }
    
    return slow + 1
}

// 5️⃣ Container With Most Water

// Pseudo code: Two pointer technique
// Take two pointers, one at the start of the array and another at the end of the array
// Calculate the area formed by the lines at the two pointers and update the maximum area if needed
// Move the pointer that has the shorter line towards the other pointer, as the area is limited by the shorter line and we want to try to find a taller line to increase the area
func maxArea(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count - 1
    var maxArea = 0
    
    while left < right {
        let currentArea = min(height[left], height[right]) * (right - left)
        maxArea = max(maxArea, currentArea)
        
        if height[left] < height[right] {
            left += 1
        } else {
            right -= 1
        }
    }
    return maxArea
}

// 🔥 PATTERN 3: Hash Map (10 Questions)
// Two sum (Unsorted Array)
//if sorted array is given then we can use two pointer technique to solve the problem in O(n) time complexity, but if the array is unsorted then we can use hash map to solve the problem in O(n) time complexity.
// Pseudo Code:
// Create one hashmap to store value as key and index as value
// Traverse nums , find out if hashmap contains [Target - currentValue] else add index to hashmap

func twoSumUnsorted(_ nums: [Int], _ target: Int) -> [Int]? {
    var hashMap: [Int: Int] = [:]
    for (index, num) in nums.enumerated() {
        if let complement = hashMap[target - num] {
            return [complement, index]
        }
    }
    return nil
}

// 2️⃣ First Unique Character
func firstUniqChar(_ s: String) -> Int {
    let chars = Array(s)
    var freq = [Character: Int]()
    for c in chars { freq[c, default: 0] += 1 }
    for i in 0..<chars.count where freq[chars[i]] == 1 {
        return i
    }
    return -1
}
    
// 3️⃣ Valid Anagram
func isAnagram(_ s: String, _ t: String) -> Bool {
    var map = [Character: Int]()
    for c in s { map[c, default: 0] += 1 }
    for c in t {
        map[c, default: 0] -= 1
        if map[c]! < 0 { return false }
    }
    return map.values.allSatisfy { $0 == 0 }
}

func containsDuplicate(_ nums: [Int]) -> Bool {
    var set = Set<Int>()
    for n in nums {
        if set.contains(n) { return true }
        set.insert(n)
    }
    return false
}

// 4️⃣ Group Anagrams
func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map = [String: [String]]()
        for s in strs {
            let key = String(s.sorted())
            map[key, default: []].append(s)
        }
        return Array(map.values)
}

// 🔥 PATTERN 4: DFS / Recursion (10 Questions)
// 1️⃣ Max Depth of Binary Tree
// Tree is about traversal, and DFS is one of the tree traversal techniques, so we can use DFS to solve the problem.

class TreeNode {
    var value: Int = 0
    var left: TreeNode?
    var right: TreeNode?
}

func treeNodeMaxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return 1 + max(treeNodeMaxDepth(root.left), treeNodeMaxDepth(root.right))
}

// 2️⃣ Invert Binary Tree
// Pseudo Code:
// If the root is nil, return nil
// Swap the left and right children of the root
// Recursively call the function on the left and right children of the root
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else { return nil }
    let leftTree = invertTree(root.left)
    let rightTree = invertTree(root.right)
    root.left = rightTree
    root.right = leftTree
    return root
}

// 3️⃣ Path Sum
// Pseudo Code:
// If the root is nil, return false
// If the root is a leaf node and its value is equal to the target sum, return true
// Recursively call the function on the left and right children of the root, with the target sum minus the value of the root

func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else { return false }
    if root.left == nil && root.right == nil {
        return root.value == targetSum
    }
    return pathSum(root.left, targetSum - root.value) || pathSum(root.right, targetSum - root.value)
}
