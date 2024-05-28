---
title: "Selection Sort"
date: 2024-05-28T07:49:30+05:30
---

# Selection Sort

Selection Sort is a simple comparison-based sorting algorithm. It operates by repeatedly finding
the minimum element (considering ascending order) from the unsorted part of an array and putting it
at the beginning. The process involves dividing the input list into two parts: a sorted sublist
which is built up from left to right, and an unsorted sublist where elements are not yet in their
final position.

<!--more-->

## Algorithm

Here's how Selection Sort works step by step:

1. Start with the first element of the array as the minimum.

2. Compare this "current" minimum with the rest of the array to find a new minimum.

3. Once you have found the true minimum, swap it with the value at the current position.

4. Move one position ahead in the array and consider this element as part of the unsorted segment
   while treating the remaining elements as the sorted sublist.

5. Repeat steps 2-4 until the entire list is sorted.

The algorithm's time complexity is O(n<sup>2</sup>) for all cases (worst, average, and best), making it
inefficient on large lists compared to more advanced algorithms like quicksort, mergesort or
heapsort. However, Selection Sort has its advantages such as simplicity and performing only a
minimal number of swaps, which can be beneficial when the cost of swap is high.

## Code

Here is an implementation in C++.

```cpp
import <print>;
import <vector>;

constexpr auto sort(std::vector<ssize_t> &vec) -> void {
  for (auto it1{vec.begin()}; it1 < vec.end(); ++it1) {
    auto it{it1};
    for (auto it2{it1 + 1}; it2 < vec.end(); ++it2) {
      if (*it2 < *it) {
        it = it2;
      }
    }
    auto temp{*it1};
    *it1 = *it;
    *it = temp;
  }
}

int main() {
  std::vector<ssize_t> v{4,  7, 3, 7, 2,    7, 4, 64, 32, 65,
                         32, 4, 5, 5, 6456, 4, 5, 53, 5};
  sort(v);

  for (const auto &a : v) {
    std::print("{} ", a);
  }

  return 0;
}

```

## Explanation

### Function Signature

```cpp
constexpr auto sort(std::vector<ssize_t> &vec) -> void
```

- `constexpr`: This keyword indicates that the function can be evaluated at compile time if provided with constant expressions. This is useful for performance optimization in some cases.
- `auto sort`: Uses the auto keyword to automatically deduce the return type. In this case, the return type is explicitly specified as `void`.
- `(std::vector<ssize_t> &vec)`: The function takes a reference to a `std::vector` of `ssize_t` integers as its parameter. Using a reference avoids copying the vector and allows the function to modify the original vector.
- `-> void`: This specifies the return type of the function, which is `void` (meaning it doesn't return a value).

### Function Body

```cpp
{
  for (auto it1{vec.begin()}; it1 < vec.end(); ++it1) {
    auto it{it1};
    for (auto it2{it1 + 1}; it2 < vec.end(); ++it2) {
      if (*it2 < *it) {
        it = it2;
      }
    }
    auto temp{*it1};
    *it1 = *it;
    *it = temp;
  }
}
```

1. **Outer Loop (Selection Sort)**:

```cpp
for (auto it1{vec.begin()}; it1 < vec.end(); ++it1)
```

- This loop iterates over each element of the vector from the beginning to the end.
- `it1` is an iterator starting from the beginning of the vector and moving towards the end.

2. **Inner Loop (Finding Minimum)**

```cpp
auto it{it1};
for (auto it2{it1 + 1}; it2 < vec.end(); ++it2) {
  if (*it2 < *it) {
    it = it2;
  }
}
```

- The inner loop starts from the next element after `it1` and iterates to the end of the vector.
- `it` initially points to `it1`, which is the current element in the outer loop.
- `it2` iterates over the remaining elements to find the smallest element.
- If `*it2` (the value pointed to by `it2`) is smaller than `*it` (the value pointed to by `it`), `it` is updated to point to `it2`.

3. **Swapping Elements**:

```cpp
auto temp{*it1};
*it1 = *it;
*it = temp;
```

- After finding the smallest element in the unsorted portion of the vector, the smallest element (pointed to by `it`) is swapped with the element at the position `it1`.
- `temp` temporarily holds the value of `*it1`.
- `*it1` is set to `*it` (the smallest element found).
- `*it` is then set to `temp` to complete the swap.

## Output

```console
❯ ./main
2 3 4 4 4 4 5 5 5 5 7 7 7 32 32 53 64 65 6456 [ble: EOF]
```
