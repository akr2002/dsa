---
title: "Heap"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Heap

## Priority Queue

A priority queue is an abstract data-type that operates similarly to a standard
queue. However, unlike a traditional queue where the first element entered (following the
First-In-First-Out or FIFO principle) is the first one to be removed, a priority queue orders
elements based on their importance or "priority."

Here are some key characteristics and functions of a priority queue:

1. Elements have priorities associated with them: Each element in the queue has an assigned priority
   value (the higher the value, the higher its priority). The priorities can be either explicitly
   defined by the user or automatically calculated based on specific criteria.

2. Queue operations are performed according to priority: When inserting a new element into the
   queue, it's placed at the appropriate position depending upon its priority level compared with other
   elements in the queue. Similarly, when removing an element from the queue (dequeueing), the
   highest-priority element is removed first and returned for processing, regardless of the order in
   which they were added.

3. Queue operations have time complexity: Most basic priority queue implementations like Fibonacci
   Heap or Binary Heap provide enqueue (insert) and dequeue (remove) operations that operate with an
   average-case time complexity of O(log n), where 'n' is the number of elements in the queue.

4. Use cases: Priority queues are widely used in various applications, such as task scheduling
   systems, resource allocation problems, graph algorithms like Dijkstra and Prim (to find shortest
   paths or minimum spanning trees), real-time simulations, event handling, etc.

## Heap

A heap is a specialized tree-based data structure that satisfies the heap property, which states
that if P is a parent node of C, then the value of P must be higher (in a max heap) or lower (in a
min heap) than the value of C. This property allows for efficient retrieval and manipulation of
elements in a specific order.

There are two main types of heaps:

1. Max-Heap: In a max-heap, parent nodes have values greater than or equal to their child nodes (the
   largest element is at the root). The heap property ensures that the maximum value can be efficiently
   retrieved in O(1) time complexity by accessing the root node and removed from the heap using a
   dequeue operation.

2. Min-Heap: In a min-heap, parent nodes have values less than or equal to their child nodes (the
   smallest element is at the root). Similar to max-heaps, both retrieval and removal operations in
   O(1) time complexity by accessing the root node.
   Functions of heap data structure include:

   - insert(): Inserts a new value into the heap while maintaining the heap property. This operation
     typically takes O(log n) time complexity, where 'n' is the number of elements within the heap.

   - delete(): Removes an element from the heap and then reorganizes it to maintain the heap
     property. Like insert, this also has a typical runtime of O(log n).

   - extract-max/min(): Retrieves the root node (which is the highest or lowest value in max/min
     heaps) while preserving the heap structure by sinking down the last element into its appropriate
     position. This operation takes O(1) time complexity for retrieval and O(log n) for removal.

   - peek(): Retrieves the root node without removing it, which is useful when you want to inspect
     the current maximum or minimum value in a heap without modifying the data structure's state. The
     complexity of this operation is also O(1).

Heap structures are widely used due to their efficiency for maintaining priority queues (max-heaps
and min-heaps), as well as other applications like graph algorithms, memory management, sorting
algorithms, etc. Their hierarchical nature makes them particularly useful in scenarios where
elements need to be processed based on a specific order or relationship.

Note: There are several variations of heaps, such as binary heaps (which can be further divided into
min-heaps and max-heaps), Fibonacci heaps, binomial heaps, etc., each with its own implementation
details, but they all share the core heap property for efficient priority queue operations.

## Algorithm

In this explanation, I will focus on implementing a Max Heap where the key at the root must be maximum among
all other keys, and the same property must be recursively true for all subtrees in the binary tree.
Here's an algorithm to construct and manipulate a Max Heap:

1. Initialization: Start with an empty array (or list) that will represent your heap.

2. Insertion: To insert an element into a Max Heap, follow these steps:
   a. Add the new element at the end of the array to maintain the complete tree structure.
   b. Compare the added element with its parent; if it's larger than its parent, swap them.
   c. Repeat step b until the heap property is restored (i.e., for each level upwards from where you
   inserted).

3. Extraction: To remove and return the maximum value in a Max Heap (which will be at root):
   a. Swap the first element with the last one to make it accessible but not part of the heap
   structure anymore.
   b. Remove the last element from the array, which now represents the previous max value.
   c. Store the old root's value; this is the maximum value you want to remove.
   d. Replace the root with the last leaf (bottom-most right node) of the heap.
   e. Compare the new root with its children and swap it with one of them if necessary, then repeat
   step d until the heap property is restored.

4. Heapify: To maintain the Max Heap structure after an insertion or deletion (step 2 & 3), you'll
   need to perform a "heapify" operation for every non-leaf node from right to left and bottom to top.
   This ensures that any violations of the heap property are fixed by swapping with children nodes
   until it holds true.

5. Peek: To view the maximum element without removing it, simply return the root of your Max Heap
   (first element in array).

6. IsFull/IsEmpty: Check if your heap is full or empty based on its capacity and current size
   respectively.

This algorithm provides a robust way to create and manipulate a Max Heap data structure while
maintaining its unique properties efficiently.

### Pseudocode

```
Insert(a, n) {
    // Inserts a[n] into the heap which is stored in a[1: n - 1]
    i = n; item = a[n];
    while ((i > 1) and (a[floor(i/2)]) < item ) do {
        a[i] = a[floor(i/2)]; i = floor(i/2);
    }
        a[i] = item;
        return true;
    }
}

Adjust(a, i, n) {
    // The complete binary trees with roots 2i and 2i + 1 are
    // combined with nodei to form a heap rooted at i. No
    // node has an address greater than n or less than 1.
    {
        j = 2i;
        item = a[i];
        while (j <= n) do {
            if ((j < n) and (a[j] < a[j + 1])) then j = j + 1;
            // Compare left and right child and let j be the larger child
            if (item >= a[j]) then break;
            // A position for item is found
            a[floor(j/2)] = a[j];
            j = 2j;
        }
        a[floor(j/2)] = item;
    }
}

DelMax(a, n, x) {
    // Delete the maximum from the heap a[1 : n] and store it in x.
    if (n = 0) then {
        print("heap empty");
        return false;
    }
    x = a[1];
    a[1] = a[n];
    Adjust(a, 1, n - 1);
    return true;
}

Heapify(a, n) {
    // Readjust the elements in a[1 : n] to form a heap
    for i = floor(n/2) to 1 step -1 do Adjust(a, i, n);
}
```

## Code

```cpp
import <print>;
import <vector>;

template <typename T> using heap_t = std::vector<T>;

auto swap(ssize_t &a, ssize_t &b) -> void {
  auto temp{b};
  b = a;
  a = temp;
}

auto heapify(heap_t<ssize_t> &heap, const size_t &i) -> void {
  const auto size{heap.size()};
  auto largest{i};
  const auto left{2 * i + 1};
  const auto right{2 * i + 2};

  if (left < size && heap[left] > heap[largest])
    largest = left;

  if (right < size && heap[right] > heap[largest])
    largest = right;

  if (largest != i) {
    swap(heap[i], heap[largest]);
    heapify(heap, largest);
  }
}

auto insert(heap_t<ssize_t> &heap, const ssize_t &data) -> void {
  ssize_t size = heap.size();
  heap.emplace_back(data);
  if (size == 0)
    return;

  for (auto i{(size / 2) - 1}; i >= 0; --i)
    heapify(heap, i);
}

auto remove_node(heap_t<ssize_t> &heap, const ssize_t &data) -> void {
  ssize_t size = heap.size();
  auto i{0zu};
  for (i = 0; i < size; ++i)
    if (data == heap[i])
      break;

  if (i == size)
    return;

  swap(heap[i], heap[size - 1]);
  heap.pop_back();

  for (auto i{(size / 2) - 1}; i >= 0; --i)
    heapify(heap, i);
}

auto print_heap(const heap_t<ssize_t> &heap) -> void {
  for (const auto &node : heap)
    std::print("{} ", node);

  std::print("\n");
}

int main() {
  heap_t<ssize_t> heap{};

  insert(heap, 12);
  insert(heap, 18);
  insert(heap, 13);
  insert(heap, 62);
  insert(heap, 5);

  std::print("Heap: ");
  print_heap(heap);

  remove_node(heap, 12);

  std::print("Heap: ");
  print_heap(heap);

  return 0;
}
```

### Explanation

1. **`heapify()` Function**

The `heapify` function ensures that a subtree with root at index `i` in an array representation of a heap satisfies the heap property: every parent node is greater than or equal to its child nodes. 

```cpp
auto heapify(heap_t<ssize_t> &heap, const size_t &i) -> void {
```
- The function `heapify` takes two parameters: a reference to a heap (of type `heap_t<ssize_t>`) and an index `i` (of type `const size_t`). The function returns `void`, indicating it does not return a value.

```cpp
  const auto size{heap.size()};
```
- `largest` is initialized to the index `i`. This variable will keep track of the largest value among the node and its children.

```cpp
  const auto left{2 * i + 1};
  const auto right{2 * i + 2};
```
- These lines calculate the indices of the left and right children of the node at index `i`. In a zero-indexed array, the left child of the node at index `i` is at `2 * i + 1` and the right child is at `2 * i + 2`.

```cpp
  if (left < size && heap[left] > heap[largest])
    largest = left;
```
This conditional checks if the left child index is within the bounds of the heap (i.e., less than `size`) and if the value at the left child is greater than the value at the current `largest` index. If both conditions are true, `largest` is updated to the left child index.

```cpp
  if (right < size && heap[right] > heap[largest])
    largest = right;
```
- Similarly, this conditional checks if the right child index is within the bounds of the heap and if the value at the right child is greater than the value at the current `largest` index. If both conditions are true, `largest` is updated to the right child index.

```cpp
  if (largest != i) {
    swap(heap[i], heap[largest]);
    heapify(heap, largest);
  }
```
- If `largest` has changed from its initial value `i`, it means that one of the children has a greater value than the current node. Therefore, the values at indices `i` and `largest` are swapped to maintain the max-heap property.
- After the swap, the `heapify` function is called recursively on the subtree rooted at `largest` to ensure that the subtree also satisfies the heap property.

2. **`insert()` Function**

This function adds a new element to the heap and then re-establishes the max-heap property. 

```cpp
auto insert(heap_t<ssize_t> &heap, const ssize_t &data) -> void {
```
- The function `insert` takes two parameters: a reference to a heap (of type `heap_t<ssize_t>`) and the data to be inserted (of type `const ssize_t`). The function returns `void`, indicating it does not return a value.

```cpp
  ssize_t size = heap.size();
```
- The variable `size` is assigned the current number of elements in the heap.

```cpp
  heap.emplace_back(data);
```
- The new data is added to the end of the heap. The `emplace_back` method inserts the element at the back of the vector (or heap).

```cpp
  if (size == 0)
    return;
```
- If the heap was empty before the insertion, the function returns immediately. There’s no need to re-heapify a single element heap.

```cpp
  for (auto i{(size / 2) - 1}; i >= 0; --i)
    heapify(heap, i);
```
- This for loop starts from the last non-leaf node and goes up to the root node, calling the `heapify` function on each node.
- The index of the last non-leaf node in a heap is `(size / 2) - 1`.
- By calling `heapify` from the bottom non-leaf nodes up to the root, the function ensures that the entire heap maintains the max-heap property after the insertion of the new element.


3. **`remove_node()` function**

This function removes a specific element from the heap and then re-establishes the max-heap property. 
```cpp
auto remove_node(heap_t<ssize_t> &heap, const ssize_t &data) -> void {
```
- The function `remove_node` takes two parameters: a reference to a heap (of type `heap_t<ssize_t>`) and the data to be removed (of type `const ssize_t`). The function returns `void`, indicating it does not return a value.

```cpp
  ssize_t size = heap.size();
```
- The variable `size` is assigned the current number of elements in the heap.

```cpp
  auto i{0zu};
  for (i = 0; i < size; ++i)
    if (data == heap[i])
      break;
```
- This loop iterates through the heap to find the index `i` of the element that matches the data to be removed. If the element is found, `i` will be the index of that element.
- `0zu` initializes `i` as a `size_t` with value 0, ensuring the correct type.

```cpp
  if (i == size)
    return;
```
- If the loop completes and `i` is equal to `size`, it means the element was not found in the heap. The function returns early without making any changes.

```cpp
  swap(heap[i], heap[size - 1]);
  heap.pop_back();
```
- The element to be removed (at index `i`) is swapped with the last element in the heap.
- The last element (which is now the element to be removed) is removed from the heap using `pop_back()`.

```cpp
  for (auto i{(size / 2) - 1}; i >= 0; --i)
    heapify(heap, i);
```
- This for loop starts from the last non-leaf node and goes up to the root node, calling the `heapify` function on each node.
- By calling `heapify` from the bottom non-leaf nodes up to the root, the function ensures that the entire heap maintains the max-heap property after the removal of the element.