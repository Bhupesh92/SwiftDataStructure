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
let indices = twoSum([2, 7, 11, 15], 26)
print("Indices of Two Sum: \(indices)")

/// ============================================================== ////////////////////////////
/// ============================================================== ////////////////////////////

// Stack
// 1️⃣ Implement a Stack Using Array
struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    func peek() -> T? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    var elementsArray: [T] {
        return elements
    }
}

// 2️⃣ Reverse a String Using Stack
func reverseString(_ str: String) -> String {
    var stack = Stack<Character>()
    for char in str {
        stack.push(char)
    }
    
    var reversedStr = ""
    while !stack.isEmpty {
        if let char = stack.pop() {
            reversedStr.append(char)
        }
    }
    return reversedStr
}

// 3️⃣ Valid Parentheses
func isValidParentheses(_ s: String) -> Bool {
    var stack = Stack<Character>()
    let mapping: [Character: Character] = [")": "(", "}": "{", "]": "["]
    
    for char in s {
        if mapping.values.contains(char) {
            stack.push(char)
        } else if let expectedOpen = mapping[char] {
            if stack.isEmpty || stack.pop() != expectedOpen {
                return false
            }
        }
    }
    return stack.isEmpty
}

let parenthesesString = "{[()]}"
let isValid = isValidParentheses(parenthesesString)
print("Is Valid Parentheses: \(isValid)")

// 4️⃣ Next Greater Element
func nextGreaterElement(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: -1, count: nums.count)
    var stack = Stack<Int>()
    
    for (index, num) in nums.enumerated() {
        while let last = stack.peek(), nums[last] < num {
            result[last] = num
            stack.pop()
        }
        stack.push(index)
    }
    return result
}
let ngeArray = [4, 5, 2, 25]
let ngeResult = nextGreaterElement(ngeArray)
print("Next Greater Elements: \(ngeResult)")

// 5️⃣ Evaluate Postfix Expression
func evaluatePostfix(_ expression: String) -> Int {
    var stack = Stack<Int>()
    let tokens = expression.split(separator: " ")
    
    for token in tokens {
        if let num = Int(token) {
            stack.push(num)
        } else {
            let right = stack.pop() ?? 0
            let left = stack.pop() ?? 0
            var result = 0
            
            switch token {
            case "+":
                result = left + right
            case "-":
                result = left - right
            case "*":
                result = left * right
            case "/":
                result = left / right
            default:
                break
            }
            stack.push(result)
        }
    }
    return stack.pop()!
}

// 6️⃣ Sort a Stack Using Another Stack
func sortStack(_ stack: inout Stack<Int>) -> Stack<Int> {
    var tempStack = Stack<Int>()
    
    while !stack.isEmpty {
        let current = stack.pop()!
        
        while !tempStack.isEmpty && tempStack.peek()! > current {
            stack.push(tempStack.pop()!)
        }
        tempStack.push(current)
    }
    return tempStack
}

var unsortedStack = Stack<Int>()
unsortedStack.push(3)
unsortedStack.push(1)
unsortedStack.push(4)
unsortedStack.push(2)
let sortedStack = sortStack(&unsortedStack)
print("Sorted Stack Top Element: \(sortedStack.peek()!)")

// 7️⃣ Min Stack
class MinStack {
    private var stack: Stack<(value: Int, currentMin: Int)> = Stack()
    
    func push(_ value: Int) {
        let currentMin = stack.isEmpty ? value : min(value, stack.peek()!.currentMin)
        stack.push((value, currentMin))
    }
    
    func pop() -> Int? {
        return stack.pop()?.value
    }
    
    func top() -> Int? {
        return stack.peek()?.value
    }
    
    func getMin() -> Int? {
        return stack.peek()?.currentMin
    }
}

// 8️⃣ Stock Span Problem

let stockPrices = [100, 80, 60, 70, 60, 75, 85]

func calculateStockSpan(_ prices: [Int]) -> [Int] {
    var span = Array(repeating: 1, count: prices.count)
    var stack = [Int]()
    
    for i in 0..<prices.count {
        while let last = stack.last, prices[last] <= prices[i] {
            stack.removeLast()
        }
        span[i] = stack.isEmpty ? i + 1 : i - stack.last!
        stack.append(i)
    }
    return span
}


// 9️⃣ Remove Adjacent Duplicates

func removeDuplicates(_ s: String) -> String {
    var stack = Stack<Character> ()
    for ch in s {
        if ch == stack.peek() {
            stack.pop()
        } else {
            stack.push(ch)
        }
    }
    return stack.elementsArray.reduce("") { $0 + String($1)}
}

print(removeDuplicates("abbaca"))

// Queue
// 1️⃣ Implement Queue Using Array

struct Queue<T> {
    private var elements: [T] = []

    mutating func enqueue(_ value: T) {
        elements.append(value)
    }

    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }

    func peek() -> T? {
        return elements.first
    }

    func isEmpty() -> Bool {
        return elements.isEmpty
    }
}

// 2️⃣ Queue Optimized Using Two Pointers (O(1) dequeue)
struct OptimizedQueue<T> {
    private var elements: [T] = []
    private var head: Int = 0

    mutating func enqueue(_ value: T) {
        elements.append(value)
    }

    mutating func dequeue() -> T? {
        guard head < elements.count else { return nil }
        let element = elements[head]
        head += 1
        
        // Optional: Clean up memory if too many elements have been dequeued
        if head > elements.count / 2 {
            elements.removeFirst(head)
            head = 0
        }
        
        return element
    }

    func peek() -> T? {
        guard head < elements.count else { return nil }
        return elements[head]
    }

    func isEmpty() -> Bool {
        return head >= elements.count
    }
}       







