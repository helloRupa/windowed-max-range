# Quadratic O(n^2) time complexity, constant O(1) space
def max_windowed_range(array, window_size)
  curr_max = nil
  (0..array.length - window_size).each do |start|
    chunk = array[start...start + window_size]
    range = chunk.max - chunk.min
    curr_max = range if curr_max.nil? || range > curr_max
  end
  curr_max
end

class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store[0]
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def enqueue(item)
    @store << item
  end

  def dequeue
    @store.shift
  end
end

class MyStack
  def initialize
    @store = []
  end

  def peek
    @store[-1]
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def push(item)
    @store << item
  end

  def pop
    @store.pop
  end
end

class StackQueue
  def initialize
    @store = MyStack.new
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def enqueue(item)
    new_queue = MyStack.new
    new_queue.push(@store.pop) until @store.empty?
    @store.push(item)
    @store.push(new_queue.pop) until new_queue.empty?
  end

  def dequeue
    @store.pop
  end
end
