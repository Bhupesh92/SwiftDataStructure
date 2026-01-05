# SwiftDataStructure

A small collection of basic data structure implementations and examples in Swift. This repository demonstrates core data structures with concise, easy-to-follow examples suitable for learning and reference.

## Contents
- Array
- Singly Linked List
- Doubly Linked List
- Stack
- Queue
- Binary Tree
- Binary Search Tree (BST)
- Heap (Max-Heap)
- Hash Table (Dictionary)
- Graph (Adjacency List)
- Trie (Prefix Tree)

## Getting Started
Clone the repository and open the Swift files in Xcode or use the Swift command-line tool.

```bash
git clone https://github.com/Bhupesh92/SwiftDataStructure.git
cd SwiftDataStructure
```

Each data structure folder contains a minimal implementation and a playground or example Swift file showing how to use it.

---

## Examples

### Array (built-in)
Basic usage with Swift's native Array.

```swift
var numbers: [Int] = [1, 2, 3]
numbers.append(4)
for n in numbers {
    print(n)
}
// Output: 1 2 3 4
```

### Singly Linked List (basic)
A minimal Node and LinkedList demonstrating append and traversal.

```swift
final class Node<T> {
    var value: T
    var next: Node?
    init(_ value: T) { self.value = value }
}

final class LinkedList<T> {
    private var head: Node<T>?

    func append(_ value: T) {
        let newNode = Node(value)
        guard let last = lastNode() else { head = newNode; return }
        last.next = newNode
    }

    private func lastNode() -> Node<T>? {
        var node = head
        while node?.next != nil { node = node?.next }
        return node
    }

    func traverse(_ body: (T) -> Void) {
        var node = head
        while let current = node {
            body(current.value)
            node = current.next
        }
    }
}

let list = LinkedList<Int>()
list.append(10)
list.append(20)
list.traverse { print($0) }
```

### Doubly Linked List (outline)
A doubly linked list adds `previous` references for O(1) removals when a node reference is known. See `DoublyLinkedList.swift` for full implementation.

### Stack
LIFO stack using an array-backed struct.

```swift
struct Stack<T> {
    private var items: [T] = []
    mutating func push(_ item: T) { items.append(item) }
    mutating func pop() -> T? { return items.popLast() }
    func peek() -> T? { return items.last }
    var isEmpty: Bool { items.isEmpty }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
print(stack.pop() ?? "nil") // 2
```

### Queue
FIFO queue using an array (simple) or a ring buffer for efficiency.

```swift
struct Queue<T> {
    private var items: [T] = []
    mutating func enqueue(_ item: T) { items.append(item) }
    mutating func dequeue() -> T? {
        guard !items.isEmpty else { return nil }
        return items.removeFirst()
    }
    var isEmpty: Bool { items.isEmpty }
}

var q = Queue<Int>()
q.enqueue(1)
q.enqueue(2)
print(q.dequeue() ?? "nil") // 1
```

### Binary Tree (Node and Traversal)
Simple binary tree node and recursive traversals.

```swift
class TreeNode<T> {
    var value: T
    var left: TreeNode?
    var right: TreeNode?
    init(_ value: T) { self.value = value }
}

func inorder<T>(_ node: TreeNode<T>?, _ visit: (T) -> Void) {
    guard let node = node else { return }
    inorder(node.left, visit)
    visit(node.value)
    inorder(node.right, visit)
}
```

### Binary Search Tree (BST)
Insertion and search in a BST.

```swift
class BSTNode<T: Comparable> {
    var value: T
    var left: BSTNode?
    var right: BSTNode?
    init(_ value: T) { self.value = value }
}

class BST<T: Comparable> {
    private(set) var root: BSTNode<T>?

    func insert(_ value: T) {
        root = insert(at: root, value: value)
    }

    private func insert(at node: BSTNode<T>?, value: T) -> BSTNode<T> {
        guard let node = node else { return BSTNode(value) }
        if value < node.value { node.left = insert(at: node.left, value: value) }
        else { node.right = insert(at: node.right, value: value) }
        return node
    }

    func contains(_ value: T) -> Bool {
        var node = root
        while let current = node {
            if value == current.value { return true }
            node = value < current.value ? current.left : current.right
        }
        return false
    }
}
```

### Heap (Max-Heap, minimal)
A compact max-heap using an array as a binary heap.

```swift
struct MaxHeap<T: Comparable> {
    private var heap: [T] = []

    mutating func insert(_ value: T) {
        heap.append(value)
        siftUp(heap.count - 1)
    }

    mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 { return heap.removeLast() }
        let val = heap[0]
        heap[0] = heap.removeLast()
        siftDown(0)
        return val
    }

    private mutating func siftUp(_ index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && heap[child] > heap[parent] {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(_ index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = left + 1
            var candidate = parent
            if left < heap.count && heap[left] > heap[candidate] { candidate = left }
            if right < heap.count && heap[right] > heap[candidate] { candidate = right }
            if candidate == parent { break }
            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
```

### Hash Table
Use Swift's native Dictionary for hash-table functionality. It supports O(1) average insert/lookup.

```swift
var dict: [String: Int] = ["apple": 3]
dict["banana"] = 2
print(dict["apple"] ?? 0)
```

### Graph (Adjacency List)
Representation and simple BFS/DFS outlines.

```swift
struct Graph {
    private(set) var adj: [Int: [Int]] = [:]
    mutating func addEdge(_ u: Int, _ v: Int, directed: Bool = false) {
        adj[u, default: []].append(v)
        if !directed { adj[v, default: []].append(u) }
    }
}

// Use BFS/DFS to traverse; see GraphExamples.swift for implementations.
```

### Trie (Prefix Tree)
Basic node and insert/search outline for prefix operations.

```swift
class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isWord = false
}

class Trie {
    private let root = TrieNode()
    func insert(_ word: String) {
        var node = root
        for ch in word {
            if node.children[ch] == nil { node.children[ch] = TrieNode() }
            node = node.children[ch]!
        }
        node.isWord = true
    }
    func search(_ word: String) -> Bool {
        var node = root
        for ch in word {
            guard let next = node.children[ch] else { return false }
            node = next
        }
        return node.isWord
    }
}
```

---

## Time Complexity (Average)
- Array access: O(1)
- Array insert/delete at end: O(1)
- Linked list insert at head/tail: O(1) (if tail known)
- Stack/Queue operations: O(1)
- BST (average): search/insert/delete O(log n) (worst O(n))
- Hash table (Dictionary): O(1) average
- Heap: insert O(log n), pop O(log n)
- Graph traversal: O(V + E)

## Contributing
Contributions welcome. Please open issues or pull requests with improvements, tests, or additional data structures.

## License
MIT
