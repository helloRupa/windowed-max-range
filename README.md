# Max Windowed Range
Calculate the maximum range (difference) of values in an array given a window size.
Programmed in Ruby.

## max_windowed_range
Inefficient but easy to understand, this method runs in Quadratic time [O(n^2)]. It calculates the range for each window-sized chunk of the array, which requires the method to create subarrays until the entire array has been traversed. For eac subarray, the method must find the max and the min, which means it traverses the array yet again to find those values - loops within a loop.

## max_window_range
More efficient and slightly harder to understand, this method runs in linear time [O(n)]. It calculates the range using a stack-queue (queue created using two stacks) that updates its own minimum and maximum values each time a value is added or removed without traversing all values. Instead, it uses a hash that associates max. and min. values with previous iterations. 

The array is traversed only once in order to build the stack-queue, and the stack-queue never grows beyond the window size. This ensures the appropriate range is calculated.

## Classes
MyQueue, MyStack, StackQueue, MinMaxStack, MinMaxStackQueue are included in the lib directory for implementing queues, stacks, queues made from stacks, and stacks that track minimum and maximum values.

## Notes
I don't normally dump all my code in one file. But today, it happened.