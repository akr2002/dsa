---
title: "Binary Search Tree"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---
# Binary Search Tree
A Binary Search Tree (BST) is a type of data structure that organizes nodes in a hierarchical
manner, where each node has at most two children: left and right. The key characteristic of a BST
lies in the way it stores elements based on their values to maintain an ordered sequence that allows
for efficient searching, insertion, and deletion operations.

<!--more-->

The fundamental properties of a binary search tree are as follows:

1. **Node Structure**: Each node contains data (value), a reference to the left child node, and a
   reference to the right child node. In addition, it may contain pointers for parent nodes in some
   implementations but this is not mandatory.

2. **Ordering Property**: For any given node in the BST, all values in its left subtree are less
   than or equal to its own value, and all values in its right subtree are greater than its own value.
   This property must hold for every single node, which is true recursively on each of its children as
   well.

3. **Efficiency**: Due to the ordering property, BSTs provide efficient time complexity for
   operations like search (on average O(log n) in a balanced tree), insertion (O(log n)), and deletion
   (O(log n)). However, these complexities can degrade to O(n) if the tree is not balanced.

The efficiency of BSTs makes them useful for various applications that require sorted data storage
with quick access times such as database indexing systems, sorting algorithms like heapsort and
mergesort (when implemented using a binary heap), and many others in computer science.

## Algorithm

### Insertion

1. **Start**: You are given the root of the BST and the integer value 'value' that needs to be
   inserted into the tree.

2. **Comparison with Root**: Begin by comparing the 'value' you wish to insert with the current root
   node's value. If it is equal, skip the following steps as duplicates are not allowed in a BST (this
   condition can vary based on specific implementation rules).

3. **Decision for Insertion Location**:

   - If the 'value' is less than the root node's value, move to the left child of the current node
     and repeat step 2.
   - If the 'value' is greater than the root node's value, move to the right child of the current
     node and repeat step 2.

4. **Find a Spot for New Node**: Continue this process of comparing the 'value' with each node it
   encounters (left or right children) until an empty spot is found (a NULL pointer), which indicates
   there is no child in that direction to insert before.

5. **Insertion**: Once you reach a NULL position, create a new BSTNode object ('new_node') with the
   'value' as its data and set it as either the left or right child of the last node visited (depending
   on whether you moved left or right previously). This creates an insertion point in the tree.

6. **End**: The algorithm ends here, and your BST now includes a new value at the correct position
   according to its ordering property.

### Deletion

1. **Start**: You are given the root of the BST and the integer 'value' that needs to be removed.

2. **Search for Target Node**: Traverse the tree starting from the root, comparing the target
   'value' with each node’s value, moving left or right depending on whether it is less than or greater
   than the current node's.

3. **Case 1 - Leaf Node**: If the target node has no children (it is a leaf), simply remove it by
   setting its parent's corresponding link to NULL.

4. **Case 2 - Single Child**: If the target node has only one child, replace it with this child. For
   example, if the left child exists, set the left child as root’s new left child and update the parent
   reference of this child accordingly.

5. **Case 3 - Both Children**: This is the most complex scenario since simply removing the node
   might disrupt the BST properties. To maintain the tree structure after removal, you need to find
   either the maximum value in the target's left subtree (to replace it as root of this subtree) or the
   minimum value in the right subtree (which will take the place of the removed node). This replacement
   ensures that the BST properties remain intact.

6. **End**: The algorithm concludes, and you should now have a tree without the target 'value'.

### Searching

1. **Start**: You are provided with the root of the BST and the integer 'value'.

2. **Initial Comparison**: Begin your search at the root node, comparing it against the target
   value. If you reach a NULL pointer during this process (which implies that the tree is empty or
   the element isn't present), stop further search as no match can be found in an empty tree.

3. **Recursive Searching Process**: Depending on whether 'value' is less than, equal to, or
   greater than the current node’s value, recursively move left if it's smaller, right if it's
   larger, and return true (the element was found) if you encounter an exact match.

4. **End of Search**: If at any point a comparison leads to an immediate equality check between
   the target 'value' and the current node’s value, stop further search as the BST property
   guarantees that this will be the only occurrence for duplicates (this step may vary based on
   specific rules about duplicates in your implementation).

5. **Outcome**: The algorithm concludes by either returning true if a match is found or false
   otherwise, indicating whether 'value' exists within the tree or not.

## Pseudocode

```
add(node, data) {
   if (node == nullptr)
      return create_node(data);
   if (data < node -> data)
      node -> left = insert_node(node -> left, data);
   else if (data > node -> data)
      node -> right = insert_node(node -> right, data);
}

remove_node(data) {
   if (root == nullptr) return root;
   if (data < root -> data)
      root -> left = remove_node(root -> left, data);
   else if (data > root -> data)
      root -> right = remove_node(root -> right, data);
   else {
      // only child or no child
      if (root -> left == nullptr) {
         temp = root -> right;
         root = nullptr;
         delete root
         return temp;
      }
      else if (root -> right == nullptr) {
         temp = root -> left;
         root = nullptr;
         delete root;
         return temp;
      }
      // two children
      temp = smallest_node(root -> right);
      root -> data = temp -> data;
      root -> right = remove_node(root -> right, temp -> data);
   }
   return root;
}

search(root, data) {
   if (root == null) return nullptr;
   if (data == root -> data) return root -> data;
   if (data < root -> data) return search(root -> left, data);
   if (data > root -> data) return search(root -> right, data);
   return root;
}
```
## Code
```cpp
import <memory>;
import <print>;

struct Node;

using node_ptr_t = std::shared_ptr<Node>;

struct Node {
  ssize_t data{};
  node_ptr_t left{}, right{};

  Node() = default;
  Node(Node &&) = default;
  explicit Node(ssize_t data, node_ptr_t left, node_ptr_t right)
      : data(std::move(data)), left(left), right(right) {}
  Node &operator=(Node &&) = default;
  Node(const Node &) = delete;
  Node &operator=(const Node &) = delete;
};

auto init_node(const ssize_t &data) -> node_ptr_t {
  auto temp{std::make_shared<Node>()};
  temp->data = data;
  temp->left = nullptr;
  temp->right = nullptr;
  return temp;
}

auto travel_inorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    travel_inorder(root->left);
    std::print("{} -> ", root->data);
    travel_inorder(root->right);
  }
}

auto travel_preorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    std::print("{} -> ", root->data);
    travel_preorder(root->left);
    travel_preorder(root->right);
  }
}

auto travel_postorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    travel_postorder(root->left);
    travel_postorder(root->right);
    std::print("{} -> ", root->data);
  }
}

auto add_node(const node_ptr_t &node, const ssize_t &data) -> node_ptr_t {
  if (node == nullptr)
    return init_node(data);
  if (data < node->data)
    node->left = add_node(node->left, data);
  else
    node->right = add_node(node->right, data);
  return node;
}

auto smallest_node(const node_ptr_t &given_node) -> node_ptr_t {
  auto current_node{given_node};
  // go to the leftmost node
  while (current_node && current_node->left != nullptr)
    current_node = current_node->left;
  return current_node;
}

auto remove_node(node_ptr_t root, const ssize_t &data) -> node_ptr_t {
  if (root == nullptr)
    return root;
  if (data < root->data)
    root->left = remove_node(root->left, data);
  else if (data > root->data)
    root->right = remove_node(root->right, data);
  else {
    if (root->left == nullptr) {
      auto temp{root->right};
      return temp;
    } else if (root->right == nullptr) {
      auto temp{root->left};
      return temp;
    }

    auto temp{smallest_node(root->right)};
    root->data = temp->data;
    root->right = remove_node(root->right, temp->data);
  }
  return root;
}

int main() {
  node_ptr_t root{nullptr};
  root = add_node(root, 8);
  root = add_node(root, 5);
  root = add_node(root, 2);
  root = add_node(root, 6);
  root = add_node(root, 7);
  root = add_node(root, 1);
  root = add_node(root, 25);
  root = add_node(root, 54);
  root = add_node(root, 4);
  root = add_node(root, 11);
  root = add_node(root, 9);
  root = add_node(root, 3);

  travel_inorder(root);
  std::print("\n");
  root = remove_node(root, 25);

  travel_inorder(root);
}
```
Here I have used smart pointers for automatic memory management.

### Explanation
1. **Headers and Type Aliases**
```cpp
import <memory>;
import <print>;
```
These lines import the necessary standard library components: `memory` for `std::shared_ptr` and `print` for outputting text.

```cpp
struct Node;

using node_ptr_t = std::shared_ptr<Node>;
```
This declares a forward declaration of the `Node` structure and a type alias `node_ptr_t` for a `std::shared_ptr<Node>`.

2. **Node Structure**
```cpp
struct Node {
  ssize_t data{};
  node_ptr_t left{}, right{};

  Node() = default;
  Node(Node &&) = default;
  explicit Node(ssize_t data, node_ptr_t left, node_ptr_t right)
      : data(std::move(data)), left(left), right(right) {}
  Node &operator=(Node &&) = default;
  Node(const Node &) = delete;
  Node &operator=(const Node &) = delete;
};
```
The `Node` structure represents a node in the BST. Each node contains:

- `data`: the value stored in the node.
- `left` and `right`: pointers to the left and right children, respectively.

The constructors and assignment operators are defined as follows:

- Default constructor: `Node() = default`.
- Move constructor and move assignment operator: `Node(Node &&) = default` and `Node &operator=(Node &&) = default`.
- Parameterized constructor: initializes `data`, `left`, and `right`.
- Copy constructor and copy assignment operator are deleted: `Node(const Node &) = delete` and `Node &operator=(const Node &) = delete` to prevent copying of nodes (only moving is allowed).

3. **Initialize a Node**
```cpp
auto init_node(const ssize_t &data) -> node_ptr_t {
  auto temp{std::make_shared<Node>()};
  temp->data = data;
  temp->left = nullptr;
  temp->right = nullptr;
  return temp;
}
```
`init_node` creates and initializes a new node with the given data.

4. **Tree Traversal Functions**
```cpp
auto travel_inorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    travel_inorder(root->left);
    std::print("{} -> ", root->data);
    travel_inorder(root->right);
  }
}

auto travel_preorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    std::print("{} -> ", root->data);
    travel_preorder(root->left);
    travel_preorder(root->right);
  }
}

auto travel_postorder(const node_ptr_t &root) -> void {
  if (root != nullptr) {
    travel_postorder(root->left);
    travel_postorder(root->right);
    std::print("{} -> ", root->data);
  }
}
```
These functions implement in-order, pre-order, and post-order traversal of the BST, respectively, and print the nodes' data during traversal.

4. **Add Node to Tree**
```cpp
auto add_node(const node_ptr_t &node, const ssize_t &data) -> node_ptr_t {
  if (node == nullptr)
    return init_node(data);
  if (data < node->data)
    node->left = add_node(node->left, data);
  else
    node->right = add_node(node->right, data);
  return node;
}
```
`add_node` recursively adds a new node with the given data to the BST, maintaining the BST property.

5. **Find the Smallest Node**
```cpp
auto smallest_node(const node_ptr_t &given_node) -> node_ptr_t {
  auto current_node{given_node};
  while (current_node && current_node->left != nullptr)
    current_node = current_node->left;
  return current_node;
}
```
`smallest_node` finds and returns the node with the smallest value in the subtree rooted at `given_node`.

6. **Remove Node from Tree**
```cpp
auto remove_node(node_ptr_t root, const ssize_t &data) -> node_ptr_t {
  if (root == nullptr)
    return root;
  if (data < root->data)
    root->left = remove_node(root->left, data);
  else if (data > root->data)
    root->right = remove_node(root->right, data);
  else {
    if (root->left == nullptr) {
      auto temp{root->right};
      return temp;
    } else if (root->right == nullptr) {
      auto temp{root->left};
      return temp;
    }

    auto temp{smallest_node(root->right)};
    root->data = temp->data;
    root->right = remove_node(root->right, temp->data);
  }
  return root;
}
```
`remove_node` removes a node with the specified data from the BST. It handles three cases:

- Node with only one child or no child.
- Node with two children: finds the in-order successor (smallest node in the right subtree), replaces the node's data with the successor's data, and then deletes the successor.

7. **`main()` Function**
```cpp
int main() {
  node_ptr_t root{nullptr};
  root = add_node(root, 8);
  root = add_node(root, 5);
  root = add_node(root, 2);
  root = add_node(root, 6);
  root = add_node(root, 7);
  root = add_node(root, 1);
  root = add_node(root, 25);
  root = add_node(root, 54);
  root = add_node(root, 4);
  root = add_node(root, 11);
  root = add_node(root, 9);
  root = add_node(root, 3);

  travel_inorder(root);
  std::print("\n");
  root = remove_node(root, 25);

  travel_inorder(root);
}
```
The `main` function demonstrates creating a BST, adding nodes to it, performing an in-order traversal, removing a node, and performing another in-order traversal.

## Output
```console
1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 -> 11 -> 25 -> 54 -> 
1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 -> 11 -> 54 -> 
```