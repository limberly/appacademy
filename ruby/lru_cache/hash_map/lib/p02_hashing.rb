class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    last = self.last
    self.inject(0) {|sum, ele| last == ele ? sum : sum ^= ele}.hash
  end
end

class String
  def hash
    arr = self.split("").map(&:ord)
    arr.hash    
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # keys = self.keys.sort {|a,b| a <=> b}.map(&:to_s).join("")
    # values = self.values.sort {|a,b| a <=> b}.map(&:to_s).join("")
    # (keys.hash ^ values.hash).hash

    keys = (self.keys + self.values).map(&:to_s).sort {|a,b| a <=> b}.join("")
    (keys + "#{keys.length}r").hash
  end
end
