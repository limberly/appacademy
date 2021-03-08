require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :store, :map
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    h = key.hash


    if !@map.get(key)
      eject!
      val = @prc.call(key)
      @store.append(key, val)
      @map.set(key, @store.last)
      @map.get(key).val
    elsif @map.get(key)
      eject!
      @store.remove(key)
      @store.append(key, val)
      @map.set(key, @store.last)
      @map.get(key).val
    end

  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    if count == @max
      k = @store.first.key
      @store.remove(k)
      @map.delete(k)
    end
  end
end
