---
title: "Sorting"
date: 2024-05-28T07:49:20+05:30
bookCollapseSection: true
---

# Sorting

This section contains entries related to sorting algorithms.

Sorting in data structures and algorithms involves rearranging a collection of items, such as
numbers or strings, into a sequence or list where the elements are organized according to a
particular criterion (e.g., ascending numerical value). Various algorithms have been developed for
this purpose, each with its own advantages and trade-offs in terms of time complexity, space
efficiency, stability, adaptability, and ease of implementation. Some widely known sorting
algorithms include:

1. **Bubble Sort** - A simple comparison-based algorithm that repeatedly steps through the list,
   compares adjacent elements, and swaps them if they are in the wrong order. It has a time complexity
   of O(n^2) in its average and worst cases.

2. **Selection Sort** - This algorithm divides the input list into two parts: a sorted sublist of
   items that are built up from left to right at the front (or beginning) of the list, and an unsorted
   sublist. On each iteration, it selects the smallest or largest element (depending on sorting order)
   from the unsorted sublist and moves that element to the end of the sorted sublist. Its time
   complexity is O(n^2).

3. **Insertion Sort** - Builds the final sorted array one item at a time. It has an average and
   worst-case performance of O(n^2), but it's efficient for small datasets or nearly sorted arrays,
   with best-case time complexity being O(n).

4. **Merge Sort** - A divide-and-conquer algorithm that divides the input array into two halves,
   recursively sorts them, and then merges the two sorted halves together. It has a time complexity of
   O(n log n) in all cases.

5. **Quick Sort** - Also utilizes a divide-and-conquer strategy by selecting a 'pivot' element from
   the array and partitioning the other elements into two sub-arrays, according to whether they are
   less than or greater than the pivot. The time complexity in average cases is O(n log n), but it can
   degrade to O(n^2) if the smallest or largest element is always chosen as the pivot.

6. **Heap Sort** - Builds a heap data structure from the input data and then repeatedly extracts
   the maximum (or minimum) element from the heap, swapping it with the last item in the unsorted
   portion of the array, and re-heaping the reduced array. The time complexity is O(n log n).

7. **Radix Sort** - This non-comparative integer sorting algorithm sorts data with integer keys by
   grouping keys by the individual digits which share the same significant position and value (radix).
   It has a linear time complexity of O(nk) where k is the number of passes of the sorting algorithm
   and n is the number of elements.

8. **Counting Sort** - Suitable for sorting integer arrays when the range of potential items in the
   input (i.e., their possible key values) is relatively small compared to the number of items. Its
   time complexity varies based on the specific implementation but generally has a linear time
   complexity, O(n+k), where k is the range of the input.

9. **Bucket Sort** - Works by distributing elements into several 'buckets' and then sorting these
   buckets individually using a different sorting algorithm or by recursively applying bucket sort to
   each bucket. Its time complexity can be as good as O(n+k) where n is the number of elements and k
   is the number of buckets, but it often performs better than O(n log n).

10. **Timsort** - A hybrid sorting algorithm derived from merge sort and insertion sort designed to
    perform well on many kinds of real-world data. It's used as the default sort in Python and Java.
    Timsort has a time complexity of O(n log n) for average and worst cases.

The choice of a particular sorting algorithm depends on several factors, including but not limited
to: the size and nature of the dataset, the computational resources available (such as CPU and
memory), the desired level of stability in the output, whether parallel computing is involved, etc.

{{<section summary >}}
