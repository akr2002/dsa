---
title: "Set"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Set

A Set is a fundamental data structure available in many programming languages, which stores unique
elements. The primary characteristic of a Set is that it contains no duplicates; each element can
appear only once. Sets are particularly useful when you want to keep track of a collection of
elements without worrying about their order or occurrence count. Here's an overview of the key
aspects and operations associated with Sets:

## Basic Definition and Properties

- **Uniqueness**: A Set is defined by its unique members, ensuring no duplicates are present within
  it. This makes checking for membership (whether a particular element exists in the set) efficient
  compared to data structures that allow duplicates, like lists or arrays.
- **Ordering**: The order of elements in a Set can vary based on the implementation and whether
  you're working with an unordered collection (like Python's `set` or Java's `HashSet`) versus an
  ordered one (e.g., Python's `frozenset`, which is actually just a frozen set, but lacks methods that
  modify its content).
- **Dynamic Size**: Sets can grow and shrink dynamically as elements are added and removed, though
  their performance characteristics depend on the underlying implementation.

## Disjoint Set

The Disjoint Set data structure, also known as Union-Find or Merge-Find Set, is a powerful abstract
data type that allows you to efficiently manage and query the connected components of a graph. It
supports two primary operations: **Union** (combining sets) and **Find** (determining which set an
element belongs to), both having efficient implementations.

### Key Properties and Operations:

1. **Disjoint Sets**: Each disjoint set consists of elements partitioned into non-overlapping
   subsets, ensuring that no two elements in the same subset are connected by a path.
2. **Union Operation**: This operation merges two distinct sets into one. It's typically implemented
   with careful consideration to maintain optimal time complexity (usually O(log n) for both insertions
   and unions).
3. **Find Operation**: Determines the representative element of a set in which an item belongs,
   usually through path compression techniques that flatten the structure of the tree representing
   sets, achieving nearly constant-time operations.

### Implementation Details:

The Disjoint Set Data Structure can be implemented using two main approaches: **Weighted Quick Union
(WQU)** and **Quick Find** for union operation, along with path compression optimization in both.
For the find operation, there are also variations like **Lazy Union** and **Path Compression** that
further optimize performance.

### Weighted Quick Union (WQU):

In WQU, each set is represented by a tree where elements point to their parents, with trees of
different sizes linked together in a specific order during the union operation to keep the depth of
the trees as balanced as possible. The find operation traverses up the parent pointers until it
finds the root of an element's set (the representative).

### Quick Find:

Quick Find is simpler but less efficient for larger datasets due to its O(n) time complexity for
both union and find operations, where n is the number of elements. Each element points directly to a
set representative. However, this method provides constant-time performance for the find operation
but not for unions or dynamic insertion.

### Path Compression:

Path compression optimizes the efficiency of both operations by making every visited node in the
find operation point directly to the root when found. This significantly reduces the height of trees
over time, leading to nearly constant-time performance even for subsequent operations.

### Applications:

Disjoint Set Data Structures are widely used in computer science applications requiring efficient
management of disconnected components, including network connectivity problems, Kruskal's algorithm
for finding a minimum spanning tree (MST) of a graph, and cycle detection in graphs.

## Algorithm

Here's an algorithm for implementing disjoint set.

### Algorithm for Disjoint Set with Path Compression

1. **Initialization**: Start by representing each element as a node, where the parent of each node
   is itself initially (indicating that they are their own sets). This can be implemented using an
   array `parent[]` where `parent[i] = i` for all elements from 0 to N-1.

2. **Find**: To find which set a particular element belongs to, follow these steps:

   - Start at the node corresponding to the given element's index (element).
   - If this node is its own parent, it's the representative of its set, and you can return this
     value directly.
   - Otherwise, recursively or iteratively traverse up through the parents until you reach an
     element that points to itself. This path represents a sequence from the given element back to the
     root of its set (the set's representative). - To optimize future Find operations, apply Path Compression: after finding the representative,
     make every node on this path point directly to the representative by updating each node's parent
     pointer to the representative. This step significantly speeds up subsequent Find operations for
     these nodes and any others connected through them.

3. **Union**: To merge two disjoint sets into a single set, execute the following steps:
   - Perform Find on both elements (A and B) to find their respective representatives (roots). Let's
     say `rootA` is the root of A's set and `rootB` is the root of B's set.
   - If they are already in the same set, no action is needed. However, if they are different sets
     (i.e., their roots are not equal), make one representative point to the other by setting the parent
     of `rootA` or `rootB` to be the other root. This unites the two sets into a single set.
   - Optionally, apply Path Compression again during this operation for all nodes found in either
     path (including those from previous Union operations) as they may need to update their pointers
     directly to the new representative.

### Pseudocode

```
SimpleUnion(i, j) {
    p[i] = j;
}

SimpleFind(i) {
    while (p[i] >= 0) do
        i = p[i];
    return i;
}

WeightedUnion(i, j) {
    // Union sets with roots i and j. i != j, using the weighting rule
    // p[i] = -count[i] and p[j] = -count[j]
    temp = p[i] + p[j];
    if (p[i] > p[j]) then
        // i has fewer nodes
        p[i] j;
        p[j] = temp;
    else
        // j has fewer or equal nodes
        p[j] = i;
        p[i] = temp;
}
```

## Code

```cpp
import <algorithm>;
import <numeric>;
import <print>;
import <ranges>;
import <vector>;

struct Set {
  std::vector<ssize_t> parent{};
  std::vector<ssize_t> rank{};

  constexpr Set(const ssize_t &size) {
    parent.resize(size);
    rank.resize(size);

    std::iota(parent.begin(), parent.end(), 0);
    std::ranges::fill(rank, 0);
  }

  constexpr auto find(const ssize_t &node) -> ssize_t {
    if (node == parent.at(node))
      return node;

    return parent.at(node) = find(parent.at(node));
  }

  constexpr auto union_set(ssize_t u, ssize_t v) -> void {
    u = find(u);
    v = find(v);

    if (u != v) {
      if (rank.at(u) < rank.at(v))
        std::swap(u, v);
      parent.at(v) = u;
      if (rank.at(u) == rank.at(v))
        ++rank[u];
    }
  }
};
int main() {
  const ssize_t size{5};
  Set disjoint_set(size);

  disjoint_set.union_set(0, 1);
  disjoint_set.union_set(1, 2);
  disjoint_set.union_set(3, 4);

  for (ssize_t i : std::ranges::iota_view{0, size})
    std::println("Find({}):{}", i, disjoint_set.find(i));

  std::print("Parent array: ");
  for (ssize_t i : std::ranges::iota_view{0, size})
    std::print("{} ", disjoint_set.parent[i]);
  std::print("\n");
  return 0;
}
```

### Explanation

#### 1. **Struct Definition**

```cpp
struct Set {
  std::vector<ssize_t> parent{};
  std::vector<ssize_t> rank{};
```

- `struct Set` defines a new struct type named `Set`.
- Inside the struct, two member variables are declared:
  - `std::vector<ssize_t> parent{}`: This is a vector that will hold the parent of each element. It is used to keep track of the representatives (or roots) of each subset.
  - `std::vector<ssize_t> rank{}`: This is a vector that will hold the rank (or depth) of each element. It is used to keep the tree flat by attaching smaller trees under the root of larger trees.

#### 2. **Constructor**

```cpp
  constexpr Set(const ssize_t &size) {
    parent.resize(size);
    rank.resize(size);

    std::iota(parent.begin(), parent.end(), 0);
    std::ranges::fill(rank, 0);
  }
```

- `constexpr Set(const ssize_t &size)` is a constructor that initializes a `Set` instance with a given size.
- `parent.resize(size);` and `rank.resize(size);` resize the `parent` and `rank` vectors to the given size, initializing them to hold `size` elements.
- `std::iota(parent.begin(), parent.end(), 0);` initializes the parent vector such that each element is its own parent. `std::iota` is a standard algorithm that fills the range with sequentially increasing values starting from 0. After this, `parent[i] == i` for all `i` in the range `[0, size)`.
- `std::ranges::fill(rank, 0);` sets all elements in the rank vector to 0. `std::ranges::fill` is a standard algorithm that assigns the value 0 to each element in the rank vector.

#### 3. **`find()` Method**

```cpp
constexpr auto find(const ssize_t &node) -> ssize_t {
    // If the node is its own parent, it is the root of its set
    if (node == parent.at(node))
        return node;

    // Path compression: recursively find the root and update the parent
    return parent.at(node) = find(parent.at(node));
}
```

##### Method Definition

```cpp
constexpr auto find(const ssize_t &node) -> ssize_t {
```

- `constexpr auto find(const ssize_t &node) -> ssize_t`: This defines a constexpr method named `find` that takes a single parameter `node` of type `ssize_t` and returns a value of type `ssize_t`.

##### Method Body

```cpp
    if (node == parent.at(node))
      return node;
```

- The method checks if `node` is its own parent, i.e., if `node` is the root of its set. This is done using `parent.at(node)`, which accesses the element at index `node` in the `parent` vector with bounds checking (thanks to the `.at()` method).
- If `node` is its own parent, it means `node` is the representative of its set, and the method returns `node`.

##### Path Compression

```cpp
    return parent.at(node) = find(parent.at(node));
```

- If `node` is not its own parent, the method recursively calls `find on parent.at(node)`, which finds the root of `node`'s set.
- The result of the recursive `find` call is then assigned back to `parent.at(node)`. This step is the path compression optimization: it makes each `node` on the path from node to the root point directly to the root. This flattens the structure of the tree, reducing the time complexity of future `find` operations.
- Finally, the method returns the root of the set containing `node`.

#### 4. **`union_set()` Method**

```cpp
constexpr auto union_set(ssize_t u, ssize_t v) -> void {
    // Find the roots of the sets containing u and v
    u = find(u);
    v = find(v);

    // If u and v are in different sets, merge them
    if (u != v) {
        // Union by rank: ensure the higher rank tree remains the root
        if (rank.at(u) < rank.at(v))
            std::swap(u, v);

        // Make u the parent of v
        parent.at(v) = u;

        // If ranks were equal, increment the rank of the new root
        if (rank.at(u) == rank.at(v))
            ++rank[u];
    }
}
```

##### Method Definition

```cpp
constexpr auto union_set(ssize_t u, ssize_t v) -> void {
```

- `constexpr auto union_set(ssize_t u, ssize_t v) -> void`: This defines a constexpr method named `union_set` that takes two parameters `u` and `v` of type `ssize_t` and returns `void`.

##### Finding the Roots

```cpp
    u = find(u);
    v = find(v);
```

- The method starts by finding the roots of the sets containing `u` and `v`. This is done using the `find` method previously defined. After this step, `u` and `v` are the representatives (roots) of their respective sets.

##### Checking if Already Unified

```cpp
    if (u != v) {
```

- The condition checks if the roots `u` and `v` are different. If they are the same, `u` and `v` are already in the same set, and no union operation is needed.

##### Union by Rank

```cpp
      if (rank.at(u) < rank.at(v))
        std::swap(u, v);
```

- If `u` and `v` are different, the method performs union by rank. It compares the ranks of the roots `u` and `v`.
  - If `rank[u] < rank[v]`, it swaps `u` and `v` to ensure that `u` has the higher rank. This keeps the tree shallower by attaching the smaller tree under the root of the larger tree.

##### Merging the Sets

```cpp
      parent.at(v) = u;
```

- The method sets `parent[v]` to `u`, effectively making `u` the parent of `v`. This merges the set containing `v` into the set containing `u`.

##### Updating the rank

```cpp
      if (rank.at(u) == rank.at(v))
        ++rank[u];
    }
```

- If the ranks of `u` and `v` were equal, the rank of the new root `u` is incremented by 1. This is because the depth of the tree increases when two trees of the same rank are merged.

#### 5. **`main()` Method**

```cpp
int main() {
  // Define the size of the disjoint set
  const ssize_t size{5};
  // Create an instance of Set with the specified size
  Set disjoint_set(size);

  // Perform union operations
  disjoint_set.union_set(0, 1);
  disjoint_set.union_set(1, 2);
  disjoint_set.union_set(3, 4);

  // Print the results of find operations for each element
  for (ssize_t i : std::ranges::iota_view{0, size})
    std::println("Find({}):{}", i, disjoint_set.find(i));

  // Print the parent array
  std::print("Parent array: ");
  for (ssize_t i : std::ranges::iota_view{0, size})
    std::print("{} ", disjoint_set.parent[i]);
  std::print("\n");
  return 0;
}
```

##### Performing Union Operations

```cpp
  disjoint_set.union_set(0, 1);
  disjoint_set.union_set(1, 2);
  disjoint_set.union_set(3, 4);
```

- `disjoint_set.union_set(0, 1);` merges the sets containing elements 0 and 1.
- `disjoint_set.union_set(1, 2);` merges the sets containing elements 1 and 2. Since 1 is already united with 0, this effectively unites elements 0, 1, and 2 into a single set.
- `disjoint_set.union_set(3, 4);` merges the sets containing elements 3 and 4.

##### Printing the Results of Find Operations

```cpp
  for (ssize_t i : std::ranges::iota_view{0, size})
    std::println("Find({}):{}", i, disjoint_set.find(i));
```

- This loop iterates over the `range [0, size)` using `std::ranges::iota_view{0, size}`.
- For each element `i`, it calls `disjoint_set.find(i)` to find the representative (root) of the set containing `i`.
- `std::println("Find({}):{}", i, disjoint_set.find(i));` prints the result in the format `Find(i):root`, where root is the representative of the set containing `i`.

##### Printing the Parent Array

```cpp
  std::print("Parent array: ");
  for (ssize_t i : std::ranges::iota_view{0, size})
    std::print("{} ", disjoint_set.parent[i]);
  std::print("\n");
```

- `std::print("Parent array: ");` prints a label for the parent array.
  This loop iterates over the range `[0, size)` using `std::ranges::iota_view{0, size}`.
- For each element `i`, it prints the value of `disjoint_set.parent[i]` followed by a space.
- `std::print("\n");` prints a newline character to end the line.

### Output

```console
❯ ./main
Find(0):0
Find(1):0
Find(2):0
Find(3):3
Find(4):3
Parent array: 0 0 0 3 3
```

#### Explanation

1. **Initialization**:

- parent array: [0, 1, 2, 3, 4]
- rank array: [0, 0, 0, 0, 0]

2. **Union Operations**:

- `union_set(0, 1)`:

  - `find(0)` returns 0.
  - `find(1)` returns 1.
  - `rank[0] == rank[1]`, so `parent[1]` is set to 0 and `rank[0]` is incremented.
  - `parent` array: [0, 0, 2, 3, 4]
  - `rank` array: [1, 0, 0, 0, 0]

- `union_set(1, 2)`:

  - `find(1)` returns 0 (since `parent[1]` is 0).
  - `find(2)` returns 2.
  - `rank[0] > rank[2]`, so `parent[2]` is set to 0.
  - `parent` array: [0, 0, 0, 3, 4]
  - `rank` array: [1, 0, 0, 0, 0]

- `union_set(3, 4)`:
  - `find(3)` returns 3.
  - `find(4)` returns 4.
  - `rank[3] == rank[4]`, so `parent[4]` is set to 3 and `rank[3]` is incremented.
  - `parent` array: [0, 0, 0, 3, 3]
  - `rank` array: [1, 0, 0, 1, 0]

3. **Find Operations**:

- `find(0)` returns 0.
- `find(1)` returns 0 (since `parent[1]` is 0).
- `find(2)` returns 0 (since `parent[2]` is 0).
- `find(3)` returns 3.
- `find(4)` returns 3 (since `parent[4]` is 3).
