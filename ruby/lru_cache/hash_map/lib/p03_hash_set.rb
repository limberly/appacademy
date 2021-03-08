class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    h = key.hash
    if !include?(key)
      resize! if @count == num_buckets
      self[h].push(h)
      @count += 1
    end
  end

  def include?(key)
    h = key.hash
    self[h].include?(h)
  end

  def remove(key)
    h = key.hash
    if include?(key)
      self[h].delete(h)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def []=(num, value)
    @store[num % num_buckets] = value
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
