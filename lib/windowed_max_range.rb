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

# Reduce to O(n) time complexity
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
    @minmax = {}
    @max = nil
    @min = nil
    populate_minmax
  end

  def populate_minmax
    if @minmax.key?(@store)
      @min = @minmax[@store][:min]
      @max = @minmax[@store][:max]
      return
    end
    @minmax[@store] = { min: @min, max: @max }
  end

  def min
    @minmax[@store][:min]
  end

  def max
    @minmax[@store][:max]
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
    @max = item if @max.nil? || item > @max
    @min = item if @min.nil? || item < @min
    @store << item
    populate_minmax
  end

  def pop
    item = @store.pop
    populate_minmax
    item
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

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def max
    @store.max
  end

  def min
    @store.min
  end

  def pop
    @store.pop
  end

  def push(item)
    @store.push(item)
  end
end

class MinMaxStackQueue
  def initialize
    @store = MinMaxStack.new
  end

  def min
    @store.min
  end

  def max
    @store.max
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
