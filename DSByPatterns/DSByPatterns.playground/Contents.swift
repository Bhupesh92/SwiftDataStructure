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



