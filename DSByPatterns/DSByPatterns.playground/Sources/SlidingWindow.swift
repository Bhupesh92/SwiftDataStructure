//
//  SlidingWindow.swift
//  
//
//  Created by Kumari Bhavana on 12/02/26.
//

class SlidingWindowPatterns {
    // More example of Sliding Window.

    func maxSumArray(size: Int) {
        var arr = [1, 4, 6,7,3]
        var maxSum = 0
        for (right, value) in arr.enumerated() {
            if size > right {
                maxSum = max(maxSum, maxSum + value)
            } else {
                maxSum = max(maxSum, maxSum + value - arr[right - size])
            }
        }
        print(maxSum)
    }

    // 2️⃣ Average of Subarrays of Size K
    func maxAvergareOfSubArraySum(size: Int) {
        var arr = [1, 4, 6,7,3]
        var maxSum = 0
        for (right, value) in arr.enumerated() {
            if size > right {
                maxSum = max(maxSum, maxSum + value)
            } else {
                maxSum = max(maxSum, maxSum + value - arr[right - size])
            }
        }
        print(Float(maxSum)/Float(size))
    }

    func avergareOfSubArraySum(size: Int) {
        var arr: [Double] = [1, 4, 6,7,3]
        var left = 0
        var windowSum: Double = 0
        var avergaeArray: [Double] = []
        for (right, value) in arr.enumerated() {
            windowSum += value
            if right >= size - 1 {
                avergaeArray.append(windowSum/Double(size))
                windowSum -= arr[right - left]
                left += 1
            }
        }
    }

    // Maximum Number of Vowels in a Substring of Length K

    func maxVowelsInString(k: Int) {
        let string = "Hiaethioru"
        var arr = Array(string)
        var vowels = ["a","e", "i", "o", "u"]
        var left = k
        var max = 0
        
        for (right, value) in arr.enumerated() {

        }
        print(max)
    }
    
    func maxArea(_ height: [Int]) -> Int {
        // two pointer approach
        // Find area of right  - left * min (leftVal n rightValue)
        // return max area
        var left = 0
        var right = height.count - 1
        var maxArea = 0
        while left < right {
            maxArea = max(maxArea, (right - left)*min(height[left], height[right]))
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }

        }
        print(maxArea)
       return maxArea
    }

// Longest Substring with At Most K Distinct Characters

func longestSubsitringWith(distinct k: Int) {
    let s = "eceba"
    let charArray = Array(s)
    var maxLen = 0
    var left = 0
    var charCount = [Character: Int]()
    
    for right in 0..<charArray.count {
        charCount[charArray[right], default: 0] += 1
        while charCount.count > k {
            charCount[charArray[left]]! -= 1
            if charCount[charArray[left]] == 0 {
                charCount.removeValue(forKey: charArray[left])
            }
            left += 1
        }
        maxLen = max(maxLen, right - left + 1)
    }
    print(maxLen)
}
}

