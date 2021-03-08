class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(@max, false)
  end

  def insert(num)
    is_valid?(num)
    @store[num] ? return : @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    !@store[num] ? return : @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise ArgumentError.new("Out of bounds") if num > @max || num < 1
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    m = num % num_buckets
    @store[m].push(num) if !include?(num)
  end

  def remove(num)
    m = num % num_buckets
    @store[m].delete(num)
  end

  def include?(num)
    m = num % num_buckets
    @store[m].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      @count += 1
      resize! if @count == num_buckets
      self[num].push(num)
    end
  end

  def remove(num)
    if include?(num)
      @count -= 1
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.clone
    @store =  Array.new(num_buckets * 2) {Array.new}
    old_store.each do |sub1|
      sub1.each do |e|
        insert(e)
        @count -= 1
      end
    end
  end
end
