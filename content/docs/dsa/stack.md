---
title: "Stack"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Stack

A stack is a fundamental abstract data type in computer science used to store a
collection of elements, with two principal operations: push (to add an element to
the top) and pop (to remove the most recently added element that was not yet
removed). This structure follows the Last In, First Out (LIFO) principle.

<!--more-->

Stacks are widely utilized in various algorithms and programming constructs due to
their simplicity and efficiency. They are particularly useful for tasks such as:

- **Syntax parsing**: For example, during the compilation process or while
  interpreting languages that use specific syntax rules like parentheses matching.

- **Backtracking problems**: Situations where you need to explore all possible
  paths (like in depth-first search) and then revert to previous states as needed.

- **Function call management**: In most programming environments, function calls
  are managed using a stack structure known as the "call stack." Whenever a function
  is called, its state gets pushed onto the call stack; when it returns, that state
  is popped off.

- **Undo mechanisms**: Any system where an action can be reversed (like in text
  editors or certain applications) often uses stacks to keep track of previous
  states.

- **Bracket matching and validation**: To check the correctness of nested
  parentheses, brackets, or braces in source code or mathematical expressions by
  ensuring they are properly balanced and ordered according to LIFO rules.

The primary operations on a stack can also include peek (to look at the top
element without removing it), isEmpty (checking if the stack is empty), size
(returning the number of elements in the stack), and others, depending on
implementation specifics.

## Algorithm

The main operations of a stack usually revolves around adding and removing items. Other helper methods can be defined such as peeking and checking for emptiness by looking at the state of the `top` pointer.

Stacks are mostly implemented using arrays or linked lists depending on the situation. If one has to go into the specifics then arrays are typically used where

1. storage is expensive,
2. the maximum entries are more or less fixed, and/or
3. performance is takes prevelance over storage.

Likewise, if the use case dictates uncertainty in maximum available storage that can be used and a little bit of performance hit is acceptable, the linked list implementation is preferred.

A typical implementation is as follows:

1. Define a Node class with at least two attributes: `data` (to store the value)
   and `next` (to point to the next node).

2. Create a Stack class that manages the linked list operations for stack
   functionality. It will have an instance variable called `top`, which points to the
   top-most element in the stack, initially set to null since the stack is empty at
   creation.

3. Implement the push operation:

   - Create a new Node with the given data value.
   - If the stack is currently empty (i.e., top == null), make the new node both
     the `top` and its next node, pointing to itself since it's the only element in the
     list at this point.
   - Otherwise, set the current `top`'s next attribute to the newly created Node,
     then update `top` to refer to the new Node. This effectively adds a new item on
     top of the stack.

4. Implement the pop operation:

   - If the stack is empty (i.e., top == null), there's nothing to remove, so you
     can return an error or raise an exception.
   - Otherwise, store the current `top`'s data value in a variable for later use
     (the popped item).
   - Update the `top` to refer to its next node and then set that previous top's
     next attribute to null, effectively removing the top element from the stack.
   - Return the stored popped value as output of this operation.

5. Implement the peek operation:

   - Check if the stack is empty (i.e., top == null). If so, return an error or
     raise an exception since there's no element to view.
   - Otherwise, return the data from the current `top` node without modifying the
     linked list structure. This allows you to see the value of the item at the top of
     the stack.

6. Implement the isEmpty operation:
   - Simply check if the `top` attribute in your Stack class is null or not, and
     return true if it's null (indicating an empty stack) or false otherwise.

However, in this case, we will only look at push and pop operations. As said earlier,
implementating other operations such as peeking and checking for emptiness is trivial
as it simply involves looking at the `top` pointer and raising the desired flag.

### Pseudocode

```
Add(item)
// Push an element on the stack. Return true is successful;
// else return false. item is used as an input.
{
    if (top >= n - 1) then
    {
        write("Stack is full");
        return false;
    }
    else
    {
        top := top + 1;
        stack[top] := item;
        return true;
    }
}

Remove(item)
// Pop the top element form the stack. Return true if successful
// else return false. item is used as output.
{
    if (top < 0) then
    {
        write("Stack is empty!");
        return false;
    }
    else
    {
        item := stack[top];
        top := top - 1;
        return true;
    }
}
```

## Code

```cpp
import <print>;

struct Node {
  ssize_t data{};
  Node *link{};
};

Node *top{nullptr};

auto add(const ssize_t &item) -> bool {
  auto temp{new Node};
  if (temp == nullptr) {
    return false;
  }
  temp->data = item;
  temp->link = top;
  top = temp;
  return true;
}

auto remove() -> bool {
  if (top == nullptr) {
    return false;
  }
  auto temp{top};
  top = top->link;
  delete temp;
  return true;
}

int main() {
  auto success{add(54)};
  if (!success) {
    std::println("Out of memory");
  }
  success = add(45);
  if (!success) {
    std::println("Out of memory");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
}
```

This is a very basic implementation and design specifics will require you to implement
it in a slightly different way but the crux remains the same.

### Explanation

1. **Imports**

```cpp
import <print>;
```

- This line imports the `<print>` library for printing to the console, which is a feature from C++23 that includes `std::println`.

2. **Node Structure**

```cpp
struct Node {
  ssize_t data{};
  Node *link{};
};
```

- This defines a structure called `Node` that represents an element in the stack.
- `ssize_t data{}`: This member holds the data of the node.
- `Node *link{}`: This is a pointer to the next node in the stack, allowing the creation of a linked list.

3. **Global Pointer**

```cpp
Node *top{nullptr};
```

- `top` is a pointer to the top node of the stack. It is initialized to `nullptr`, indicating that the stack is initially empty.

4. **`add()` Function**

```cpp
auto add(const ssize_t &item) -> bool {
  auto temp{new Node};
  if (temp == nullptr) {
    return false;
  }
  temp->data = item;
  temp->link = top;
  top = temp;
  return true;
}
```

- This function adds an item to the stack.
- `auto temp{new Node};`: Creates a new node and assigns it to the pointer temp.
- `if (temp == nullptr) { return false; }`: Checks if memory allocation failed (though in modern C++ with new, this check is redundant because [new throws an exception on failure](https://en.cppreference.com/w/cpp/memory/new/operator_new#Exceptions)).
- `temp->data = item;`: Assigns the input item to the data part of the new node.
- `temp->link = top;`: Links the new node to the current top node.
- `top = temp;`: Updates the top pointer to the new node.
- Returns `true` to indicate success.

5. **`remove()` Function**

```cpp
auto remove() -> bool {
  if (top == nullptr) {
    return false;
  }
  auto temp{top};
  top = top->link;
  delete temp;
  return true;
}
```

- This function removes an item from the stack.
- `if (top == nullptr) { return false; }`: Checks if the stack is empty.
- `auto temp{top};`: Temporarily stores the top node.
- `top = top->link;`: Updates the top pointer to the next node in the stack.
- `delete temp;`: Deletes the old top node.
- Returns `true` to indicate success.

6. **`main()` Function**

```cpp
int main() {
  auto success{add(54)};
  if (!success) {
    std::println("Out of memory");
  }
  success = add(45);
  if (!success) {
    std::println("Out of memory");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
  success = remove();
  if (!success) {
    std::println("Stack empty");
  }
}
```

- The `main` function tests the stack operations.
- `auto success{add(54)};`: Attempts to add `54` to the stack and checks for success.
- If adding fails, it prints "Out of memory".
- `success = add(45);`: Attempts to add `45` to the stack and checks for success.
  It then repeatedly tries to remove elements from the stack, printing "Stack empty" if the stack is empty.

## Code (using smart pointers)

Usage of raw pointers should be avoided whenever possible for safety reasons. Here is a possible implementation using smart pointers.

```cpp
import <memory>;
import <print>;

struct Node;

using node_ptr_t = std::shared_ptr<Node>;

struct Node {
  ssize_t data{};
  std::shared_ptr<Node> link{};

  Node() = default;
  Node(Node &&) = default;
  explicit Node(ssize_t data, node_ptr_t link)
      : data(std::move(data)), link(link) {}
  Node &operator=(Node &&) = default;
  Node(const Node &) = delete;
  Node &operator=(const Node &) = delete;
};

node_ptr_t top{nullptr};

auto add(const ssize_t &item) -> bool {
  auto temp{std::make_shared<Node>()};
  if (temp == nullptr) {
    return false;
  }
  temp->data = item;
  temp->link = top;
  top = temp;
  return true;
}

auto remove() -> bool {
  if (top == nullptr) {
    return false;
  }
  auto temp{top};
  top = top->link;
  return true;
}

int main() {
  if (auto success{add(54)}; !success) {
    std::println("Out of memory");
  }

  if (auto success{add(45)}; !success) {
    std::println("Out of memory");
  }

  if (auto success{remove()}; !success) {
    std::println("Stack empty");
  }
  if (auto success{remove()}; !success) {
    std::println("Stack empty");
  }
  if (auto success{remove()}; !success) {
    std::println("Stack empty");
  }
  if (auto success{remove()}; !success) {
    std::println("Stack empty");
  }
}
```

The implementation is mostly the same with a few notable exceptions:

- No `new` and `delete` operators as intended.
- Guard rails to prevent implicit copying.

### Explanation

1. **Forward Declaration**

```cpp
struct Node;
```

- Forward declares the `Node` struct so it can be used in the `node_ptr_t` type definition before being fully defined.

2. **Type Definition**

```cpp
using node_ptr_t = std::shared_ptr<Node>;
```

- Defines `node_ptr_t` as an alias for `std::shared_ptr<Node>`, which is a smart pointer to manage `Node` objects.

3. **`Node` Structure**

```cpp
struct Node {
  ssize_t data{};
  std::shared_ptr<Node> link{};

  Node() = default;
  Node(Node &&) = default;
  explicit Node(ssize_t data, node_ptr_t link)
      : data(std::move(data)), link(link) {}
  Node &operator=(Node &&) = default;
  Node(const Node &) = delete;
  Node &operator=(const Node &) = delete;
};
```

- `Node` contains two members:
  - `data`: Stores the value of the node.
  - `link`: Points to the next node in the stack using `std::shared_ptr<Node>`.
- Constructors and assignment operators:
  - Default constructor (`Node() = default`).
  - Move constructor (`Node(Node &&) = default`).
  - Parameterized constructor (`explicit Node(ssize_t data, node_ptr_t link)`) to initialize `data` and `link`.
  - Move assignment operator (`Node &operator=(Node &&) = default`).
  - Copy constructor and copy assignment operator are deleted to prevent copying (`Node(const Node &) = delete` and `Node &operator=(const Node &) = delete`).

## Output

```console
❯ ./main
Stack empty
Stack empty
```
