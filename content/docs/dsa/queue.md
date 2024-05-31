---
title: "Queue"
weight: 2
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Queue

A queue in data structures and algorithms is a linear collection of elements that follows the
First-In-First-Out (FIFO) principle. This means that the first element added to the queue will be
the first one to be removed. Queues are used when there's a need to process elements sequentially,
maintaining the order in which they were received or inserted.

<!--more-->

Queues have various applications and can be implemented using different data structures such as
arrays, linked lists (singly or doubly), or even specialized queues like circular queues that help
optimize space efficiency by reusing unused memory slots.

Key operations associated with queues include:

- **Enqueue**: Add an element to the rear end of the queue.
- **Dequeue**: Remove and return the front element from the queue.
- **Peek or Front**: Return the value at the front without removing it, useful for checking what's
  next in line.
- **isEmpty**: Check if the queue is empty.
- **IsFull (for some implementations like fixed-size queues)**: Determine whether the queue has
  reached its maximum capacity.

Queues are crucial in various algorithms and systems, such as scheduling tasks in operating systems,
handling events or requests in event-driven programming, managing task processing in concurrent
systems (like thread execution order), and serving a fundamental role in network buffering and data
streaming applications.

## Algorithm

Queues can be implemented using an array or a linked list. The use cases, pros and cons are the same as explained in [stack](../stack#algorithm). A typical queue implementation using array and linked list are outlined below:

1. **Enqueue (Adding an Element)**: When you want to add an element to the queue, we follow these
   steps:

   - Check if there is space in the queue (i.e., it isn't full). In a fixed-size queue, this
     involves checking if there are any unused slots left after adding the new item.
   - Add the new element at the rear of the queue. If you're using an array implementation and reach
     its end, you would typically wrap around to start positioning the next element (like in a circular
     queue). This step involves updating pointers or indexes that mark where elements begin and end
     within the data structure.

2. **Dequeue (Removing an Element)**: To remove an element from the queue while maintaining the FIFO
   order, do this:

   - Check if there's any element to dequeue—if the queue is empty, you cannot proceed with removal.
   - Remove and return the front element of the queue. This involves taking the first element out of
     the collection that has been maintained by your enqueue operations.
   - If using an array implementation, after removing an item from the start, we typically move all
     subsequent elements one position forward to fill in the gap left by the removed element (like
     shifting items downwards).

3. **Peek or Front**: This operation doesn't modify the queue but allows you to look at what the
   next item to be dequeued would be without actually removing it. Essentially, you access the element
   at the front of your queue. In an array-based implementation, this is just a read operation on the
   first index or position in the queue where elements are stored.

4. **IsEmpty**: This check simply tells you whether there's anything to enqueue or dequeue—it
   returns true if no element is present and false otherwise. For an array-based queue, this can be as
   simple as checking if your front index points at a valid element (i.e., not zero in the case of a
   non-zero indexed array).

5. **IsFull**: Only for fixed-size queues. It checks whether all slots are occupied and no room is
   left to add new elements. This would involve comparing an internal size counter or index against the
   defined capacity of your queue.

When implementing a queue algorithm, it's also essential to handle edge cases appropriately, like
dealing with operations on an empty queue, ensuring efficiency in terms of time complexity for each
operation (especially important for large queues), and maintaining data integrity throughout the
process.

In this case, we will only look at enqueue and dequeue operations. Implementing `peek`, `IsEmpty` and `IsFull` is trivial as it simply involves looking at the pointer and deciding the course of action.

### Pseudocode

```
Add(item)
// Insert item in the circular queue stored in q[0 : n - 1].
// rear points to the alst item, and front is one
// position counterclockwise from the first item in q
{
    rear := (rear + 1) mod n; // Advance rear clockwise
    if (front == rear) then
    {
        write("Queue is full");
        if (front == 0) then rear := n - 1;
        else rear := rear -1;
        // Move rear one position counterclockwise
        return false;
    }
    else
    {
        q[rear] := item; // Insert new item
        return true;
    }
}

Remove(item)
// Removes and returns the front element of the queue q[0 : n - 1]
{
    if (front == rear) then
    {
        write("Queue is empty");
        return false;
    }
    else
    {
        front := (front + 1) mod n; // Advance front clockwise
        item := q[front]; // Set item to front of queue
        return true;
    }
}
```

## Code

```cpp
import <optional>;
import <print>;

struct Node {
  ssize_t data{};
  Node *link{};
};

Node *rear{}, *front{};

auto add(const ssize_t &item) -> void {
  auto temp{new Node};
  temp->data = item;
  rear ? rear->link = temp : nullptr;
  rear = temp;
  if (front == nullptr)
    front = temp;
}

auto remove() -> std::optional<decltype(front->data)> {
  if (front == nullptr)
    return std::nullopt;
  auto temp{front};
  std::optional<decltype(front->data)> temp_data{front->data};
  front = front->link;
  delete temp;
  return temp_data;
}

auto remove_and_print_result() -> void {
  if (auto result{remove()}; result.has_value()) {
    std::println("{}", result.value());
  } else {
    std::println("empty");
  }
}

int main() {
  add(34);
  add(87);
  add(54);

  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();

  return 0;
}
```

This is a very basic implementation and design specifics will require you to implement it in a slightly different way but the crux remains the same.

### Explanation

1. **Structure and Global Variables**

```cpp
struct Node {
  ssize_t data{};
  Node *link{};
};

Node *rear{}, *front{};
```

- `struct Node` defines a node in the linked list, containing:
  - `ssize_t data{}`: the data stored in the node, initialized to zero.
  - `Node *link{}`: a pointer to the next node in the list, initialized to `nullptr`.
  - `Node *rear{}, *front{}`; are global pointers to the rear (end) and front (beginning) of the queue, both initialized to `nullptr`.

2. **`add()` Function**

```cpp
auto add(const ssize_t &item) -> void {
  auto temp{new Node};
  temp->data = item;
  rear ? rear->link = temp : nullptr;
  rear = temp;
  if (front == nullptr)
    front = temp;
}
```

- `add(const ssize_t &item)`: Adds a new item to the queue.
  - Creates a new Node and assigns it to `temp`.
  - Sets `temp->data` to the item being added.
  - If `rear` is not `nullptr`, sets `rear->link` to `temp`.
  - Updates `rear` to `temp`.
  - If `front` is `nullptr` (queue was empty), sets `front` to `temp`.

3. **`remove()` Function**

```cpp
auto remove() -> std::optional<decltype(front->data)> {
  if (front == nullptr)
    return std::nullopt;
  auto temp{front};
  std::optional<decltype(front->data)> temp_data{front->data};
  front = front->link;
  delete temp;
  return temp_data;
}
```

- `remove()`: Removes an item from the front of the queue and returns it.
  - If `front` is `nullptr`, returns `std::nullopt` (indicating the queue is empty).
  - Saves the current front node in `temp`.
  - Stores the data of the front node in a `std::optional` called `temp_data`.
  - Updates `front` to the next node (`front->link`).
  - Deletes the old front node (`temp`).
  - Returns `temp_data`.

4. **`remove_and_print_result()` Function**

```cpp
auto remove_and_print_result() -> void {
  if (auto result{remove()}; result.has_value()) {
    std::println("{}", result.value());
  } else {
    std::println("empty");
  }
}
```

- `remove_and_print_result()`: Removes an item from the queue and prints the result.
  - Calls `remove()` and stores the result in `result`.
  - If `result` has a value, prints the value.
  - Otherwise, prints "empty".

5. **`main()` Function**

```cpp
int main() {
  add(34);
  add(87);
  add(54);

  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();

  return 0;
}
```

- `main()`: The main entry point of the program.
  - Adds three items (34, 87, 54) to the queue using `add()`.
  - Calls `remove_and_print_result()` four times, attempting to remove and print items from the queue. Since there are only three items, the fourth call will print "empty".

## Code (using smart pointers)

Usage of raw pointers should be avoided whenever possible for safety reasons. Here is a possible implementation using smart pointers.

```cpp
import <memory>;
import <optional>;
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

node_ptr_t rear{}, front{};

auto add(const ssize_t &item) -> void {
  auto temp{std::make_shared<Node>()};
  temp->data = item;
  rear ? rear->link = temp : nullptr;
  rear = temp;
  if (front == nullptr)
    front = temp;
}

auto remove() -> std::optional<decltype(front->data)> {
  if (front == nullptr)
    return std::nullopt;
  auto temp{front};
  std::optional<decltype(front->data)> temp_data{front->data};
  front = front->link;
  return temp_data;
}

auto remove_and_print_result() -> void {
  if (auto result{remove()}; result.has_value()) {
    std::println("{}", result.value());
  } else {
    std::println("empty");
  }
}

int main() {
  add(34);
  add(87);
  add(54);

  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();
  remove_and_print_result();

  return 0;
}
```

Same as usual, except no `new` and `delete` operators.

## Output

```console
❯ ./main
34
87
54
empty
```
