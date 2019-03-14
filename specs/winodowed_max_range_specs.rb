require 'rspec'
require 'windowed_max_range'

## Extend classes for testing only
class MyQueue
  attr_reader :store
end

class MyStack
  attr_reader :store
end

class StackQueue
  attr_reader :store
end

class MinMaxStack
  attr_reader :store
end

class MinMaxStackQueue
  attr_reader :store
end
## End testing class extensions

describe '#max_windowed_range' do
  subject(:arr) { [1, 0, 2, 5, 4, 8] }

  it 'chooses the max difference using a 2 element window' do
    expect(max_windowed_range(arr, 2)).to eq(4)
  end

  it 'chooses the max difference using a 3 element window' do
    expect(max_windowed_range(arr, 3)).to eq(5)
  end

  it 'chooses the max difference using a 4 element window' do
    expect(max_windowed_range(arr, 4)).to eq(6)
  end

  it 'chooses the max difference using a 5 element window' do
    expect(max_windowed_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end

describe 'MyQueue' do
  subject(:queue) { MyQueue.new }
  def add_items
    queue.enqueue(0)
    queue.enqueue(1)
    queue.enqueue(2)
  end

  describe '#initialize' do
    it 'creates an instance variable, store, holding an empty array' do
      expect(queue.store).to eq([])
    end
  end

  describe '#enqueue' do
    it 'adds items to store in order from first added to last added' do
      add_items
      expect(queue.store).to eq([0, 1, 2])
    end
  end

  describe '#dequeue' do
    it 'removes an item from the front of store and returns it' do
      add_items
      expect(queue.dequeue).to eq(0)
      expect(queue.store).to eq([1, 2])
    end
  end

  describe '#peek' do
    it 'returns the first item without removing it' do
      add_items
      expect(queue.peek).to eq(0)
      expect(queue.store).to eq([0, 1, 2])
    end
  end

  describe '#empty?' do
    it 'returns false when store contains items' do
      add_items
      expect(queue.empty?).to be(false)
    end

    it 'returns true when store is empty' do
      expect(queue.empty?).to be(true)
    end
  end

  describe '#size' do
    it 'returns the size of store' do
      add_items
      expect(queue.size).to eq(3)
    end
  end
end

describe 'MyStack' do
  subject(:stack) { MyStack.new }
  def add_items
    stack.push(0)
    stack.push(1)
    stack.push(2)
  end

  describe '#initialize' do
    it 'creates an empty array called store' do
      expect(stack.store).to eq([])
    end
  end

  describe '#push' do
    it 'adds items to store in order from first to last' do
      add_items
      expect(stack.store).to eq([0, 1, 2])
    end
  end

  describe '#pop' do
    it 'removes an item from the end of store and returns it (FILO)' do
      add_items
      expect(stack.pop).to eq(2)
      expect(stack.store).to eq([0, 1])
    end
  end

  describe '#peek' do
    it 'returns the last item of store without removing it' do
      add_items
      expect(stack.peek).to eq(2)
      expect(stack.store).to eq([0, 1, 2])
    end
  end

  describe '#size' do
    it 'returns the size of store' do
      add_items
      expect(stack.size).to eq(3)
    end
  end

  describe '#empty?' do
    it 'returns false when store contains items' do
      add_items
      expect(stack.empty?).to be(false)
    end

    it 'returns true when store is empty' do
      expect(stack.empty?).to be(true)
    end
  end

  describe '#min' do
    it 'returns the lowest valued item in store' do
      add_items
      expect(stack.min).to eq(0)
    end

    it 'returns correct lowest valued item after items have been removed' do
      add_items
      stack.push(-100)
      stack.pop
      expect(stack.min).to eq(0)
    end
  end

  describe '#max' do
    it 'returns the highest valued item in store' do
      add_items
      expect(stack.max).to eq(2)
    end

    it 'returns correct highest valued item after items have been removed' do
      add_items
      stack.push(100)
      stack.pop
      expect(stack.max).to eq(2)
    end
  end
end

describe 'StackQueue' do
  subject(:hybrid) { StackQueue.new }

  def add_items
    hybrid.enqueue(0)
    hybrid.enqueue(1)
    hybrid.enqueue(2)
  end

  describe '#initialize' do
    it 'creates an instance from our stack class called store' do
      expect(hybrid.store).to be_an_instance_of(MyStack)
    end
  end

  describe '#enqueue' do
    it 'adds items in reverse order, e.g. adding 0 > 1 > 2 makes [2, 1, 0]' do
      add_items
      expect(hybrid.store.store).to eq([2, 1, 0])
    end
  end

  describe '#dequeue' do
    it 'removes the first item that was added and returns it' do
      add_items
      expect(hybrid.dequeue).to eq(0)
      expect(hybrid.store.store).to eq([2, 1])
    end
  end

  describe '#size' do
    it 'returns the numbers of items stored in the queue-stack' do
      add_items
      expect(hybrid.size).to eq(3)
    end
  end

  describe '#empty?' do
    it 'returns false when queue-stack contains items' do
      add_items
      expect(hybrid.empty?).to be(false)
    end

    it 'returns true when queue-stack is empty' do
      expect(hybrid.empty?).to be(true)
    end
  end
end

describe 'MinMaxStack' do
  subject(:stack) { MinMaxStack.new }
  def add_items
    stack.push(0)
    stack.push(1)
    stack.push(2)
  end

  describe '#initialize' do
    it 'creates an instance of MyStack called store' do
      expect(stack.store).to be_an_instance_of(MyStack)
    end
  end

  describe '#push' do
    it 'adds items to store in order from first to last' do
      add_items
      expect(stack.store.store).to eq([0, 1, 2])
    end
  end

  describe '#pop' do
    it 'removes an item from the end of store and returns it (FILO)' do
      add_items
      expect(stack.pop).to eq(2)
      expect(stack.store.store).to eq([0, 1])
    end
  end

  describe '#peek' do
    it 'returns the last item of store without removing it' do
      add_items
      expect(stack.peek).to eq(2)
      expect(stack.store.store).to eq([0, 1, 2])
    end
  end

  describe '#size' do
    it 'returns the size of store' do
      add_items
      expect(stack.size).to eq(3)
    end
  end

  describe '#empty?' do
    it 'returns false when store contains items' do
      add_items
      expect(stack.empty?).to be(false)
    end

    it 'returns true when store is empty' do
      expect(stack.empty?).to be(true)
    end
  end

  describe '#min' do
    it 'returns the lowest valued item in store' do
      add_items
      expect(stack.min).to eq(0)
    end

    it 'returns correct lowest valued item after items have been removed' do
      add_items
      stack.push(-100)
      stack.pop
      expect(stack.min).to eq(0)
    end
  end

  describe '#max' do
    it 'returns the highest valued item in store' do
      add_items
      expect(stack.max).to eq(2)
    end

    it 'returns correct highest valued item after items have been removed' do
      add_items
      stack.push(100)
      stack.pop
      expect(stack.max).to eq(2)
    end
  end
end

describe 'MinMaxStackQueue' do
  subject(:hybrid) { MinMaxStackQueue.new }

  def add_items
    hybrid.enqueue(0)
    hybrid.enqueue(1)
    hybrid.enqueue(2)
  end

  describe '#initialize' do
    it 'creates an instance of MinMaxStack in store' do
      expect(hybrid.store).to be_an_instance_of(MinMaxStack)
    end
  end

  describe '#enqueue' do
    it 'adds items in reverse order, e.g. adding 0 > 1 > 2 makes [2, 1, 0]' do
      add_items
      expect(hybrid.store.store.store).to eq([2, 1, 0])
    end
  end

  describe '#dequeue' do
    it 'removes the first item that was added and returns it' do
      add_items
      expect(hybrid.dequeue).to eq(0)
      expect(hybrid.store.store.store).to eq([2, 1])
    end
  end

  describe '#size' do
    it 'returns the numbers of items stored in the queue-stack' do
      add_items
      expect(hybrid.size).to eq(3)
    end
  end

  describe '#empty?' do
    it 'returns false when queue-stack contains items' do
      add_items
      expect(hybrid.empty?).to be(false)
    end

    it 'returns true when queue-stack is empty' do
      expect(hybrid.empty?).to be(true)
    end
  end

  describe '#min' do
    it 'returns the lowest valued item in store' do
      add_items
      expect(hybrid.min).to eq(0)
    end

    it 'returns correct lowest valued item after items have been removed' do
      add_items
      hybrid.enqueue(-100)
      hybrid.dequeue
      expect(hybrid.min).to eq(-100)
    end
  end

  describe '#max' do
    it 'returns the highest valued item in store' do
      add_items
      expect(hybrid.max).to eq(2)
    end

    it 'returns correct highest valued item after items have been removed' do
      add_items
      hybrid.enqueue(100)
      hybrid.dequeue
      expect(hybrid.max).to eq(100)
    end
  end
end

describe '#max_window_range' do
  subject(:arr) { [1, 0, 2, 5, 4, 8] }

  it 'chooses the max difference using a 2 element window' do
    expect(max_window_range(arr, 2)).to eq(4)
  end

  it 'chooses the max difference using a 3 element window' do
    expect(max_window_range(arr, 3)).to eq(5)
  end

  it 'chooses the max difference using a 4 element window' do
    expect(max_window_range(arr, 4)).to eq(6)
  end

  it 'chooses the max difference using a 5 element window' do
    expect(max_window_range([1, 3, 2, 5, 4, 8], 5)).to eq(6)
  end
end
