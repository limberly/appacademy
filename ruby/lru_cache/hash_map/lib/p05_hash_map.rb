require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    h = key.hash
    @store[h % num_buckets].include?(key)
  end

  def set(key, val)
    h = key.hash
    buc = @store[h % num_buckets]
    if @count == num_buckets
      resize!
    end
    if buc.include?(key)
      buc.update(key, val) 
    else
      buc.append(key, val)
      @count += 1
    end
  end

  def get(key)
    h = key.hash
    buc = @store[h % num_buckets]
    return buc.get(key) if !buc.nil?
    nil
  end

  def delete(key)
    h = key.hash
    @store[h % num_buckets].remove(key)
    @count -= 1
  end

  include Enumerable

  def each
    @store.each do |linked_list|
      linked_list.each do |pair|
        yield [pair.key, pair.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    fake = @store.clone
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    fake.each do |linked_list|
      linked_list.each do |node|
        self.set(node.key, node.val)  
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
