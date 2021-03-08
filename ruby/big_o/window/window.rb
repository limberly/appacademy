def windowed_max_range(arr, range)
    current_max = 0
    arr.each_with_index do |e, id|
        break if arr[id + range - 1].nil?
        window = arr[id..(id+range-1)]
        min = window.min
        max = window.max
        large = max - min
        current_max = large if large > current_max
    end
    current_max
end


class MyQueue
    def initialize
        @store = []
    end

    def peek
        @store.last
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def enqueue(e)
        @store << e
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
        @store.last
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def pop
        @store.pop
    end

    def push(e)
        @store.push(e)
    end
end

class StackQueue
    def initialize
        @in_stack = MyStack.new
        @out_stack = MyStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?        
    end

    def enqueue(e)
        @in_stack.push(e)
    end

    def dequeue
        queueify if @out_stack.empty?
        @out_stack.pop
    end

    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end

end

class MinMaxStack
    def initialize
        @store = MyStack.new
    end

    def peek
        @store.peek[:value] unless empty?
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def max
        @store.peek[:max] unless empty?
    end

    def min
        @store.peek[:min] unless empty?
    end

    def pop
        @store.pop[:value] unless empty?
    end

    def push(val)
        @store.push({
            max: new_max(val),
            min: new_min(val),
            value: val
        })
    end

    private

    def new_max(val)
        empty? ? val : [max, val].max
    end

    def new_min(val)
        empty? ?val : [min, val].min
    end
end

class MinMaxStackQueue
    def initialize
        @in_stack = MinMaxStack.new
        @out_stack = MinMaxStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?        
    end

    def enqueue(e)
        @in_stack.push(e)
    end

    def dequeue
        queueify if @out_stack.empty?
        @out_stack.pop
    end

    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end

    def max
        maxes = []
        maxes << @in_stack.max unless @in_stack.empty?
        maxes << @out_stack.max unless @out_stack.empty?
        maxes.max
    end

    def min
        mins = []
        mins << @in_stack.min unless @in_stack.empty?
        mins << @out_stack.min unless @out_stack.empty?
        mins.min
    end
end

def max_windowed_range(array, window_size)
    queue = MinMaxStackQueue.new
    best_range = nil

    array.each_with_index do |e, id|
        queue.enqueue(e)
        queue.dequeue if queue.size > window_size

        if queue.size == window_size
            current_range = queue.max - queue.min
            best_range = current_range if !best_range || current_range > best_range
        end
    end
  
    best_range
  end