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

var arrayWithZeroes = [0, 1, 1, 0, 12, 1]
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

// 3️⃣ Implement Queue Using Two Stacks
struct QueueUsingStacks<T> {
    private var stackIn: Stack<T> = Stack()
    private var stackOut: Stack<T> = Stack()
    
    mutating func enqueue(_ value: T) {
        stackIn.push(value)
    }
    
    mutating func dequeue() -> T? {
        if stackOut.isEmpty {
            while !stackIn.isEmpty {
                if let value = stackIn.pop() {
                    stackOut.push(value)
                }
            }
        }
        return stackOut.pop()
    }
    
    mutating func peek() -> T? {
        if stackOut.isEmpty {
            while !stackIn.isEmpty {
                if let value = stackIn.pop() {
                    stackOut.push(value)
                }
            }
        }
        return stackOut.peek()
    }
    
    func isEmpty() -> Bool {
        return stackIn.isEmpty && stackOut.isEmpty
    }
}

// 4️⃣ Reverse a Queue

func reverseQueue<T>(_ queue: inout Queue<T>) {
    var stack = Stack<T>()
    
    while let element = queue.dequeue() {
        stack.push(element)
    }
    
    while let element = stack.pop() {
        queue.enqueue(element)
    }
}

// 5️⃣ Circular Queue Implementation

struct CircularQueue<T> {
    private var elements: [T?]
    private var head: Int = 0
    private var tail: Int = 0
    private var capacity: Int
    private var size: Int = 0

    init(capacity: Int) {
        self.capacity = capacity
        self.elements = Array(repeating: nil, count: capacity)
    }

    mutating func enqueue(_ value: T) -> Bool {
        guard size < capacity else { return false }
        elements[tail] = value
        tail = (tail + 1) % capacity
        size += 1
        return true
    }

    mutating func dequeue() -> T? {
        guard size > 0 else { return nil }
        let value = elements[head]
        elements[head] = nil
        head = (head + 1) % capacity
        size -= 1
        return value
    }

    func peek() -> T? {
        return elements[head]
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func isFull() -> Bool {
        return size == capacity
    }
    
    func currentSize() -> Int {
        return size
    }
    
}

// 6️⃣ Generate Binary Numbers Using Queue
func generateBinaryNumbers(n: Int) -> [String] {
    var result: [String] = []
    var queue = Queue<String>()
    queue.enqueue("1")
    
    for _ in 0..<n {
        if let front = queue.dequeue() {
            result.append(front)
            queue.enqueue(front + "0")
            queue.enqueue(front + "1")
        }
    }
    return result
}

// 7️⃣ First Non-Repeating Character in Stream
func firstNonRepeatingCharacter(_ stream: String) -> [Character?] {
    var charCount: [Character: Int] = [:]
    var queue = Queue<Character>()
    var result: [Character?] = []
    
    for char in stream {
        charCount[char, default: 0] += 1
        queue.enqueue(char)
        
        while let front = queue.peek(), charCount[front]! > 1 {
            queue.dequeue()
        }
        
        result.append(queue.peek())
    }
    return result
}

// 8️⃣ Sliding Window Maximum

func slidingWindowMaximum(_ nums: [Int], _ k: Int) -> [Int] {
    var result: [Int] = []
    var deque: [Int] = []
    
    for i in 0..<nums.count {
        while !deque.isEmpty && deque.first! <= i - k {
            deque.removeFirst()
        }
        
        while !deque.isEmpty && nums[deque.last!] < nums[i] {
            deque.removeLast()
        }
        
        print("index:,deque: \(i) \(deque)")
        deque.append(i)
        print("Append index:,deque: \(i) \(deque)")
        if i >= k - 1 {
            result.append(nums[deque.first!])
        }
    }
    return result
}

func interleaveQueue(_ queue: [Int]) -> [Int] {
    let half = queue.count / 2
    var q = queue
    var stack = [Int]()

    for _ in 0..<half {
        stack.append(q.removeFirst())
    }

    while !stack.isEmpty {
        q.append(stack.removeLast())
    }

    for _ in 0..<half {
        q.append(q.removeFirst())
    }

    for _ in 0..<half {
        stack.append(q.removeFirst())
    }

    while !stack.isEmpty {
        q.append(stack.removeLast())
        q.append(q.removeFirst())
    }
    return q
}

// 🔹 Linked List Node (Base Structure)

class ListNode<T> {
    var value: T
    var next: ListNode?

    init(value: T) {
        self.value = value
        self.next = nil
    }
}

// 1️⃣ Reverse a Linked List

func reverseLinkedList<T>(_ head: ListNode<T>?) -> ListNode<T>? {
    var prev: ListNode<T>? = nil
    var current = head
    
    while current != nil {
        let nextTemp = current?.next
        current?.next = prev
        prev = current
        current = nextTemp
    }
    return prev
}

// 2️⃣ Detect Cycle in Linked List
func hasCycle<T>(_ head: ListNode<T>?) -> Bool {
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
            return true
        }
    }
    return false
}

// 3️⃣ Find Middle of Linked List
func findMiddle<T>(_ head: ListNode<T>?) -> ListNode<T>? {
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    return slow
}

// 4️⃣ Merge Two Sorted Linked Lists
func mergeTwoSortedLists<T: Comparable>(_ l1: ListNode<T>?, _ l2: ListNode<T>?) -> ListNode<T>? {
    let dummy = ListNode(value: l1!.value)
    var tail: ListNode<T>? = dummy
    var list1 = l1
    var list2 = l2
    
    while list1 != nil && list2 != nil {
        if list1!.value < list2!.value {
            tail?.next = list1
            list1 = list1?.next
        } else {
            tail?.next = list2
            list2 = list2?.next
        }
        tail = tail?.next
    }
    
    if list1 != nil {
        tail?.next = list1
    } else {
        tail?.next = list2
    }
            
    return dummy.next
}
// 5️⃣ Remove Nth Node From End of List
func removeNthFromEnd<T>(_ head: ListNode<T>?, _ n: Int) -> ListNode<T>? {
    let dummy = ListNode(value: head!.value)
    dummy.next = head
    var first: ListNode<T>? = dummy
    var second: ListNode<T>? = dummy
    
    for _ in 0...n {
        first = first?.next
    }
    
    while first != nil {
        first = first?.next
        second = second?.next
    }
    
    second?.next = second?.next?.next
    return dummy.next
}

// 6️⃣ Check if Linked List is Palindrome
func isPalindromeLinkedList<T: Equatable>(_ head: ListNode<T>?) -> Bool {
    var slow = head
    var fast = head
    var prev: ListNode<T>? = nil
    
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        let nextTemp = slow?.next
        slow?.next = prev
        prev = slow
        slow = nextTemp
    }
    
    if fast != nil {
        slow = slow?.next
    }
    
    while prev != nil && slow != nil {
        if prev!.value != slow!.value {
            return false
        }
        prev = prev?.next
        slow = slow?.next
    }
    
    return true
}

// 7️⃣ Intersection of Two Linked Lists
func getIntersectionNode<T>(_ headA: ListNode<T>?, _ headB: ListNode<T>?) -> ListNode<T>? {
    var pointerA = headA
    var pointerB = headB
    
    while pointerA !== pointerB {
        pointerA = (pointerA == nil) ? headB : pointerA?.next
        pointerB = (pointerB == nil) ? headA : pointerB?.next
    }
    return pointerA
}

// 8️⃣ Remove Duplicates from Sorted Linked List

func removeDuplicatesFromSortedList<T: Equatable>(_ head: ListNode<T>?) -> ListNode<T>? {
    var current = head
    
    while current != nil && current?.next != nil {
        if current!.value == current!.next!.value {
            current?.next = current?.next?.next
        } else {
            current = current?.next
        }
    }
    return head
}

// 9️⃣ Add Two Numbers Represented by Linked Lists
func addTwoNumbers(_ l1: ListNode<Int>?, _ l2: ListNode <Int>?) -> ListNode<Int>? {
    let dummy = ListNode(value: 0)
    var p = l1
    var q = l2
    var current = dummy
    var carry = 0
    while p != nil || q != nil {
        let x = p?.value ?? 0
        let y = q?.value ?? 0
        let sum = carry + x + y
        carry = sum / 10
        current.next = ListNode(value: sum % 10)
        current = current.next!
        p = p?.next
        q = q?.next
    }
    if carry > 0 {
        current.next = ListNode(value: carry)
    }
    return dummy.next
}

// 🔟 Rotate Linked List
func rotateRight<T>(_ head: ListNode<T>?, _ k: Int) -> ListNode<T>? {
    guard let head = head else { return nil }
    
    var length = 1
    var tail = head
    while tail.next != nil {
        tail = tail.next!
        length += 1
    }
    
    let rotations = k % length
    if rotations == 0 { return head }
    
    tail.next = head
    var stepsToNewHead = length - rotations
    var newTail: ListNode<T>? = tail
    while stepsToNewHead > 0 {
        newTail = newTail?.next
        stepsToNewHead -= 1
    }
    let newHead = newTail?.next
    newTail?.next = nil
    return newHead
}

// Top 10 Hash Map Questions in Swift (DSA)
// 1️⃣ Two Sum

func twoSumHashMap(_ nums: [Int], _ target: Int) -> [Int] {
    // One dictionary to store index and complement value
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

// 2️⃣ Frequency Count of Elements
func frequencyCount(_ nums: [Int]) -> [Int: Int] {
    var frequencyMap = [Int: Int]()
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    return frequencyMap
}

// 3️⃣ First Non-Repeating Character
func firstNonRepeatingCharacterHashMap(_ s: String) -> Int? {
    var charCount = [Character: Int]()
    for char in s {
        charCount[char, default: 0] += 1
    }
    for (index, char) in s.enumerated() {
        if charCount[char] == 1 {
            return index
        }
    }
    return nil
}

// 4️⃣ Group Anagrams
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var anagramMap = [String: [String]]()
    for str in strs {
        let sortedStr = String(str.sorted())
        anagramMap[sortedStr, default: []].append(str)
    }
    return Array(anagramMap.values)
}

// 5️⃣ Find Duplicate Elements
func findDuplicates(_ nums: [Int]) -> [Int] {
    
    var seen = Set<Int>()
    var duplicates = Set<Int>()
    
    for num in nums {
        if seen.contains(num) {
            duplicates.insert(num)
        } else {
            seen.insert(num)
        }
    }
    
    return Array(duplicates)
}


// 6️⃣ Longest Substring Without Repeating Characters
func lengthOfLongestSubstringHashMap(_ s: String) -> Int {
    var charIndexMap = [Character: Int]()
    var leftPointer = 0
    var maxLength = 0
    for (rightPointer, char) in s.enumerated() {
        if let duplicateIndex = charIndexMap[char], duplicateIndex >= leftPointer {
            leftPointer = duplicateIndex + 1
        }
        charIndexMap[char] = rightPointer
        maxLength = max(maxLength, rightPointer - leftPointer + 1)
    }
    return maxLength
}


// 7️⃣ Subarray Sum Equals K
func subarraySumEqualsK(_ nums: [Int], _ k: Int) -> Int {
    var sumCountMap = [Int: Int]()
    sumCountMap[0] = 1
    var currentSum = 0
    var count = 0
    for num in nums {
        currentSum += num
        if let complementCount = sumCountMap[currentSum - k] {
            count += complementCount
        }
        sumCountMap[currentSum, default: 0] += 1
    }
    
    return count
}

// 8️⃣ Check if Two Strings Are Isomorphic

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    
    if s.count != t.count {
        return false
    }
    var mapST = [Character: Character]()
    var mapTS = [Character: Character]()
    let sArr = Array(s)
    let tArr = Array(t)

    for i in 0..<sArr.count {
        if mapST[sArr[i]] != nil && mapST[sArr[i]] != tArr[i] {
            return false
        }
        if mapTS[tArr[i]] != nil && mapTS[tArr[i]] != sArr[i] {
            return false
        }
        mapST[sArr[i]] = tArr[i]
        mapTS[tArr[i]] = sArr[i]
    }
    return true
}

// 9️⃣ Top K Frequent Elements
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequencyMap = [Int: Int]()
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    let sortedElements = frequencyMap.sorted { $0.value > $1.value }
    print(sortedElements)
    var result: [Int] = []
    for i in 0..<k {
        result.append(sortedElements[i].key)
    }
    
    return result
}

// 🔟 Intersection of Two Arrays
func intersectionOfArrays(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var set1 = Set<Int>(nums1)
    var resultSet = Set<Int>()
    for num in nums2 {
        if set1.contains(num) {
            resultSet.insert(num)
        }
    }
    return Array(resultSet)
}

// 🔥 Top 20 Swift Programs Using Higher-Order Functions Only
// 1️⃣ Find Even Numbers from an Array
func findEvenNumbers(_ nums: [Int]) -> [Int] {
    return nums.filter {$0 % 2 == 0}
}

// 2️⃣ Square of Each Element
func squareElements(_ nums: [Int]) -> [Int] {
    return nums.map { $0 * $0 }
}

// 3️⃣ Sum of All Elements
func sumOfElements(_ nums: [Int]) -> Int {
    return nums.reduce(0, +)
}

// 4️⃣ Find Maximum Element
func findMaximum(_ nums: [Int]) -> Int? {
   // return nums.max()
    let fromReduce = nums.reduce(0) { partialResult, val in
        return partialResult > val ? partialResult : val
    }
    return fromReduce
}

// 5️⃣ Count Occurrences of Each Element
func countOccurrences(_ nums: [Int]) -> [Int: Int] {
    return nums.reduce(into: [:]) { counts, num in
        counts[num, default: 0] += 1
        
    }
}

// 6️⃣ Remove Nil Values
func removeNilValues(_ array: [Int?]) -> [Int] {
    return array.compactMap { $0 }
}

// 7️⃣ Convert Array of Strings to Integers

func convertStringsToIntegers(_ strings: [String]) -> [Int] {
    return strings.compactMap { Int($0) }
}

// 8️⃣ Flatten 2D Array
func flatten2DArray<T>(_ array: [[T]]) -> [T] {
    return array.flatMap { $0 }
}


let stringNumber: String? = "123"

// Using map results in a nested optional: Optional(Optional(123))
let mappedResult = stringNumber.map { Int($0) } // Type: Int??

// Using flatMap results in a single optional: Optional(123)
let flatMappedResult = stringNumber.flatMap { Int($0) } // Type: Int?

// 9️⃣ Check If All Elements Are Positive
func areAllElementsPositive(_ nums: [Int]) -> Bool {
    return nums.allSatisfy { $0 > 0 }
}

// 🔟 Check If Any Element Is Negative
func isAnyElementNegative(_ nums: [Int]) -> Bool {
    return nums.contains { $0 < 0 }
}

// 1️⃣3️⃣ Join Strings with Comma
func joinStringsWithComma(_ strings: [String]) -> String {
    let words = ["strings", "2333"]
    let joined = words.reduce("") { $0.isEmpty ? $1 : $0 + ", " + $1 }
    return strings.joined(separator: ", ")
}

// 1️⃣4️⃣ Find Duplicate Elements
func findDuplicateElements(_ array: [Int]) -> [Int] {
    return array.reduce([Int: Int]()) { partialResult, val in
        if let value = partialResult[val] {
            var newResult = partialResult
            newResult[val] = value + 1
            return newResult
        } else {
            var newResult = partialResult
            newResult[val] = 1
            return newResult
        }
    }.filter { $0.value > 1 }.map { $0.key }
}

print(joinStringsWithComma([("Hello"), String("World"), String("Swift")]))
// Random important DS problems

// 1️⃣ Reverse a String / Array
func reverse<T>(_ array: inout [T]) {
    var left = 0
    var right = array.count - 1
    while left < right {
        array.swapAt(left, right)
        left += 1
        right -= 1
    }
}

//// func reverseString(_ s: String) -> String
//func reverseString(_ s: String) -> String {
//    var chars = Array(s)
//    
//    var left = 0
//    var right = chars.count - 1
//    
//    while left < right {
//        chars.swapAt(left, right)
//        left += 1
//        right += 1
//    }
//    
//    return String(chars)
//}

func twoSumDuplicate(_ nums: [Int], _ target: Int) -> [Int] {
    var map = [Int: Int]()

    for (index, num) in nums.enumerated() {
        let compliment =  target - num
        if let i = map[compliment] {
            return [i, index]
        }
        map[num] = index
    }
    return []
}

twoSumDuplicate([2,7,11,15], 13)

func firstUniqueChar(_ s: String) -> Int {
    var charCount = [Character: Int]()

    
    for char in s {
        charCount[char, default: 0] += 1
    }
    

    
    for (index, char) in s.enumerated() {
        if charCount[char] == 1 {
            return index
        }
    }
    
    return -1
}

func moveZeroes(_ nums: inout [Int]) {
    var nonZeroIndex = 0
    
    for i in 0..<nums.count {
        if nums[i] != 0 {
            nums[nonZeroIndex] = nums[i]
            nonZeroIndex += 1
        }
    }
    
    while nonZeroIndex < nums.count {
        nums[nonZeroIndex] = 0
        nonZeroIndex += 1
    }
    print(nums)
}

var arrayWithZeroes1 = [1,1,0,3,12]
moveZeroes(&arrayWithZeroes1)


func isPalindrome(_ x: Int) -> Bool {
    let str = String(x)
    var left = 0
    var right = str.count - 1
    let chars = Array(str)
    while left < right {
        if chars[left] != chars [right] {
            return false
        }
        left += 1
        right -= 1
    }
    return true
}

func isPalindromeWithoutConvert(_ x: Int) -> Bool {
    if x < 0 { return false }

    var original = x
    var reversed = 0

    while original > 0 {
        let digit = original % 10
        reversed = reversed * 10 + digit
        original /= 10
    }

    return x == reversed
}

func missingNumber(_ nums: [Int]) -> Int {
    let count = nums.count
    let expectedSum = count * (count + 1) / 2
    let actualSum = nums.reduce(0, +)
    return expectedSum - actualSum
}

// 🔹 Longest Substring Without Repeating Characters
func lengthOfLongestSubstring(_ s: String) -> Int {
    var mapToCheckDuplicate = [Character: Int]()
    var leftPointer = 0
    var maxLength = 0
    
    for (rightPointer, char) in s.enumerated() {
        if let duplicateIndex = mapToCheckDuplicate[char], duplicateIndex >= leftPointer {
            leftPointer = duplicateIndex + 1
        }
        mapToCheckDuplicate[char] = rightPointer
        maxLength = max(maxLength, rightPointer - leftPointer + 1)
    }
    
    return maxLength
}
// ababc
func majorityElement(_ nums: [Int]) -> Int {
    // map to store max count and its value
    var countMap = [Int: Int]()
    
    for (index, num)  in nums.enumerated() {
        countMap[num, default: 0] += 1
        if countMap[num]! > nums.count / 2 {
            return num
        }
    }
    return -1
}

func majorityByBooyerMoore(_ nums: [Int]) -> Int {
    var count = 0
    var candidate: Int?
    
    for num in nums {
        if count == 0 {
            candidate = num
        }
        count += (num == candidate) ? 1 : -1
    }
    return candidate!
}

// Count Digits of a Number

func countDigits(_ n: Int) -> Int {
    if n == 0 {
        return 1
    }
    var count  = 0
    var number = n
    while number >= 1 {
        number = number / 10
        count += 1
    }
    return count
}

print(countDigits(124))

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var set1 = Set<Int>(nums1)
    var resultSet = Set<Int>()
    
    for num in nums2 {
        if set1.contains(num) {
            resultSet.insert(num)
        }
    }
    return Array(resultSet)
    
}

// Given an unsorted integer array nums, find the smallest missing positive integer.
func firstMissingPositive(_ nums: [Int]) -> Int {
    
    if nums.count == 0 {
        return 1
    }
    
    var numSet = Set<Int>(nums)
    
    for index in 1...nums.count {
        if !numSet.contains(index) {
            return index
        }
    }
    return nums.count + 1
}

// Given an integer array nums, return an array output such that: output[i] = product of all elements of nums except nums[i] in O(n) time
func productExceptSelf(_ nums: [Int]) -> [Int] {
    
    let n = nums.count
    var output = Array(repeating: 1, count: n)
    
    var leftProduct = 1
    for i in 0..<n {
        output[i] = leftProduct
        leftProduct *= nums[i]
    }
    
    var rightProduct = 1
    for i in (0..<n).reversed() {
        output[i] *= rightProduct
        rightProduct *= nums[i]
    }
    
    return output
}

func maxProfit(_ prices: [Int]) -> Int {
    var minPrice = Int.max
    var maxProfit = 0
            
    for price in prices {
        if price < minPrice {
            minPrice = price
        } else if price - minPrice > maxProfit {
            maxProfit = price - minPrice
        }
    }
    
    return maxProfit
}

maxProfit([7,1,5,3,6,4])

//// TOP 10 MUST-KNOW CODING TRICKS / PATTERNS


// 1️⃣ Two Pointer Technique

/*
 When to use
 Sorted arrays
 Reversals
 Pair problems
 */


func twoPointerApproach() {
    let arr = [1, 2, 3, 4, 5, 6]
    var left = 0
    var right = arr.count - 1
    
    while left < right {
        print("Left: \(arr[left]), Right: \(arr[right])")
        left += 1
        right -= 1
    }
}

// 2️⃣ Sliding Window technique
/*
 When to use
 Subarrays / substrings
 “Longest / shortest / at most / exactly K”
 
 Common problems
 Longest substring without repeats
 Max sum subarray
 Substring with K distinct characters
*/

//func slidingWindowApproach() {
//    var left = 0
//
//    for right in 0..<10 {
//        print("Window: [\(left), \(right)]")
//
//        if condition fails {
//            left += 1
//        }
//    }
//}


// 3️⃣ Hash Map / Frequency Count

/*
    When to use
    Counting occurrences
    Grouping items
    duplicates
 
 var map = [Int: Int]()
 map[val, default: 0] += 1
 
    Common problems
    Two sum
    Anagram grouping
    First non-repeating character

 */

// 4️⃣ Set for Uniqueness

/*
    When to use
    Track unique items
    Remove duplicates
    Membership checks
 
 var set = Set<Int>()
 if !set.contains(x) {
     set.insert(x)
 }
 
 */

// 5️⃣ Prefix / Suffix Accumulation

/*
    When to use
    Cumulative sums/products
    Range queries
    Dynamic programming base cases
    
    var prefixSum = [Int](repeating: 0, count: n + 1)
    for i in 0..<n {
        prefixSum[i + 1] = prefixSum[i] + arr[i]
    }
    */

// 6️⃣ Fast and Slow Pointers
/*
    When to use
    Cycle detection
    Middle element finding
    Linked list problems
    
    var slow = head
    var fast = head
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    */

// 7️⃣ Stack Using Array

/*
 
 When to use
 Nested structure
 Matching pairs
 
 Valid parentheses
 Next greater element
 Evaluate expressions
 
 var stack = [Character]()
 stack.append(x)
 let top = stack.removeLast()
 
*/

// 8️⃣ Greedy Tracking (Min / Max So Far)

/*
When to use
Optimization
Single-pass profit problems
Pattern
minVal = min(minVal, current)
maxAns = max(maxAns, current - minVal)
Common problems
Stock buy/sell
Maximum difference

*/

// 9️⃣ XOR Trick
/*
    When to use
    Find unique elements
    Bit manipulation
    Pattern
    result = 0
    for num in nums {
        result ^= num
    }
    
    Common problems
    Single number
    Missing number
    */

// 🔟 Boyer–Moore Voting Algorithm
/*
When to use
Majority element (> n/2)
Pattern
var count = 0
var candidate = 0

for num in nums {
    if count == 0 {
        candidate = num
    }
    count += (num == candidate) ? 1 : -1
}
 
Common problems
Majority element
*/

/*
 
*/

// 🌳 Tree in Data Structures?

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int) {
        self.val = val
    }
}

//🔑 3. Top Tree Algorithms (MASTER THESE = Solve ALL Tree Questions)
//🧠 Mental Model
//“Almost every tree problem = Traversal + Condition”


// DFS Traversals

// ➤ Inorder (L → Root → R)

func inorderTraversal(_ root: TreeNode?){
    guard let node = root else { return }
    inorderTraversal(node.left)
    print(node.val)
    inorderTraversal(node.right)
}

// ➤ Preorder (Root → L → R)
func preorderTraversal(_ root: TreeNode?){
    guard let root = root else { return }
    print(root.val)
    preorderTraversal(root.left)
    preorderTraversal(root.right)
}

// ➤ Postorder (L → R → Root)
func postorderTraversal(_ root: TreeNode?){
    guard let root = root else { return }
    postorderTraversal(root.left)
    postorderTraversal(root.right)
    print(root.val)
}

// 2️⃣ Level Order Traversal (BFS)
func levelOrderTraversal(_ root: TreeNode?) {
    guard let root = root else { return }
    // Make a queue to push breadth-wise nodes
    // While queue is not empty, run a loop on count of queue and
    // dequeu queue add value into result array and then insert left and right children of each node to queue.
    
    var queue: [TreeNode] = [root]
    var resut: [[Int]] = []
    
    while queue.isEmpty == false {
        let levelSize = queue.count
        var currentLevel: [Int] = []
        
        for _ in 0..<levelSize {
            let currentNode = queue.removeFirst()
            currentLevel.append(currentNode.val)
            
            if let left = currentNode.left {
                queue.append(left)
            }
            if let right = currentNode.right {
                queue.append(right)
            }
        }
        resut.append(currentLevel)
    }
    print(resut)
}

// 3️⃣ Height / Max Depth of Tree
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    let leftDepth = maxDepth(root.left)
    let rightDepth = maxDepth(root.right)
    return max(leftDepth, rightDepth) + 1
}

// 4️⃣ Check if Tree is Balanced
func isBalanced(_ root: TreeNode?) -> Bool {
    func checkBalance(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        
        let leftHeight = checkBalance(node.left)
        if leftHeight == -1 { return -1 }
        
        let rightHeight = checkBalance(node.right)
        if rightHeight == -1 { return -1 }
        
        if abs(leftHeight - rightHeight) > 1 {
            return -1
        }
        
        return max(leftHeight, rightHeight) + 1
    }
    
    return checkBalance(root) != -1
}
// 5️⃣ Diameter of Binary Tree // Maximum difference between two nodes
func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    var diameter = 0
    
    func depth(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        
        let leftDepth = depth(node.left)
        let rightDepth = depth(node.right)
        
        diameter = max(diameter, leftDepth + rightDepth)
        
        return max(leftDepth, rightDepth) + 1
    }
    
    depth(root)
    return diameter
}

// 🔓 Top DSA Algorithms / Patterns That Unlock Almost All Questions
// ======
// 1️⃣ Sliding Window
/* 📌 Use when: Subarray / substring, “longest”, “shortest”, “k size”, continuous range
Idea
Maintain a window and move left/right pointers
 
 Unlocks
 ✔ Longest substring
 ✔ Max sum subarray
 ✔ Window problems
*/

func slidingWindow(_ s: String) -> Int {
    let chars = Array(s)
    var left = 0 //
    var map = [Character: Int]()
    var result = 0 // to store the length of longest substring without repeating characters

    for right in 0..<chars.count {
        map[chars[right], default: 0] += 1

        while map[chars[right]]! > 1 { // If condition fails, move left pointer to shrink the window
            map[chars[left]]! -= 1
            left += 1
        }
        result = max(result, right - left + 1)
    }
    return result
}

// 2️⃣ Two Pointers
// 📌 Use when: Sorted array, pairs, reversing
/*
 Unlocks
 ✔ Two Sum (sorted)
 ✔ Remove duplicates
 ✔ Palindrome check
 */

func twoPointers(_ nums: [Int]) {
    var left = 0
    var right = nums.count - 1

    while left < right {
        // logic
        left += 1
        right -= 1
    }
}


// 3️⃣ Hash Map / Frequency Counter
// 📌 Use when: Lookup, counts, duplicates, anagrams
/*
 Unlocks
 ✔ Two Sum
 ✔ Group Anagrams
 ✔ First unique element
 */

var mapD = [Int: Int]()
for num in nums {
    mapD[num, default: 0] += 1
}

// 4️⃣ Prefix Sum
// 📌 Use when: Cumulative sums, range queries

/*
 ✔ Subarray sum equals K
 ✔ Continuous range sums
 */

var map = [0: 1]
var sum = 0
var k = 3
for num in nums {
    sum += num
    if let count = map[sum - k] { // Sum - k is the complement we want to find
        // found
    }
    map[sum, default: 0] += 1
}
