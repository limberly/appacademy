# Monkey-Patch Ruby's existing Array class to add your own custom methods
require 'byebug'
class Array
    def span
        if self.length > 0
            self.max - self.min
        else
            nil
        end
    end

    def average
        Integer(self) rescue nil
        Float(self) rescue nil
        return nil if self.length == 0
        self.sum(0.0) / self.length
    end

    def median
        len = self.length
        half = len / 2
        return nil if len == 0
        odd = len.odd?
        if odd
            self.sort[half]
        else
            self.sort[half - 1..half].average
        end
    end

    def counts
        hash = Hash.new(0)
        self.each {|ele| hash[ele] += 1}
        hash
    end

    def my_count(arg)
        self.counts[arg]
    end

    def my_index(arg)
        self.each_with_index {|ele, id| return id if ele == arg}
        return nil
    end
    
    def my_uniq
        new = []
        self.counts.keys.each {|k| new << self[self.my_index(k)]}
        new
    end

    def my_transpose
        len = self.length
        new = Array.new(len) {Array.new(len)}
        (0...len).each do |n1|
            (0...len).each do |n2|
                new[n2][n1] = self[n1][n2]
            end
        end
        new
    end
end
