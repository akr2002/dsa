---
title: "Trees"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
bookCollapseSection: true
# bookComments: false
# bookSearchExclude: false
---

A tree, is a hierarchical way of organizing
elements (often referred to as nodes) where each element has zero or more child elements. It is one
of the most fundamental and widely used abstract data types (ADT). The structure consists of nodes
connected by edges, with distinct properties:

<!--more-->

- **Root**: A special node at the top of a tree from which all other nodes descend. In some
  implementations, there might not be a root if it's an empty tree.

- **Parent and Child Nodes**: Each child node has one parent except for the root node, which doesn't
  have any parents. There is exactly one edge between each pair of parent and its children (no shared
  children).

- **Leaf Nodes**: These are nodes that do not have any children. They represent the "end" points in
  a tree structure.

- **Edges/Links**: Connections between nodes, which can be directed or undirected. In binary trees
  (a special kind of tree), an edge typically represents one possible path from a parent to its
  child(ren).

There are several types of trees that have specific properties and uses:

- **Binary Trees**: Each node has at most two children, which can be named as the left child and
  right child. Examples include Binary Search Trees (BST), AVL trees, Red-Black trees etc.

- **Ternary Trees**: Each node may have up to three children. One common example is a Ternary Search
  Tree used in text indexing.

- **Balanced Trees**: These are binary trees that maintain their height as balanced with respect to
  some metric (such as the number of nodes), like AVL and Red-Black trees, which help to ensure
  operations on them run efficiently.

- **B-trees and B+ Trees**: Non-binary tree structures used in databases and filesystems due to
  their ability to handle large amounts of data with good performance for insertions, deletions, and
  lookups.

Trees are employed in various applications such as searching (e.g., binary search),
sorting (in some cases using a heap structure which is a specific type of tree), managing
hierarchical data, parsing expressions, routing protocols like Dijkstra's algorithm for finding the
shortest path, and more.

{{<section summary >}}
