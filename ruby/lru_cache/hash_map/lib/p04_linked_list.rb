require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_next = @head
    until current_next.next.key == key
      return nil if current_next.next.key.nil?
      current_next = current_next.next
      
    end
    return current_next.next.val
  end

  def include?(key)
    current_next = @head
    until current_next.next.key == key
      return false if current_next.next.key.nil?
      current_next = current_next.next
    end
    true
  end

  def append(key, val)
      current_next = @head
      until current_next.next == @tail
        current_next = current_next.next
      end
      current_next.next = Node.new(key, val)
      current_next.next.prev = current_next
      current_next.next.next = @tail
      @tail.prev = current_next.next
  end

  def update(key, val)
    current_next = @head
    unless current_next.next == @tail
      until current_next.next.key == key
        current_next = current_next.next
      end
      current_next.next.val = val
    end
  end

  def remove(key)
    current_next = @head
    until current_next.next.key == key
      current_next = current_next.next
      return nil if current_next.next.key.nil?
    end
    current_next.next.remove
  end

  def each
    current_next = @head.next
    until current_next.key.nil?
      yield current_next
      current_next = current_next.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
