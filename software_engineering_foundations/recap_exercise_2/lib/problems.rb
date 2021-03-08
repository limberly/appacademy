require 'byebug'
# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
  return num_1 if num_1 % num_2 == 0
  return num_2 if num_2 % num_1 == 0
  
  count = 1
  while true
    mult = num_1 * count
    count += 1
    if  mult % num_2 == 0
        return mult
    end
end
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
  bis = Hash.new(0)
  str_len = str.length - 1
  (0...str_len).each do |c1|
    bi = str[c1..c1+1]
    bis[bi] += 1
  end
  bis.sort {|(k1, v1), (k2, v2)| v2 <=> v1}[0][0]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        new_hash = {}
        self.map {|k, v| new_hash[v] = k}
        new_hash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        arr_len = self.length - 1
        (0...arr_len).each do |n1|
            ((n1+1)..arr_len).each do |n2|
                count += 1 if (self[n1] + self[n2]) == num
            end
        end
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new {|a,b| a <=> b}

        sorted = false
        arr_len = self.length - 1
        while !sorted
            sorted = true
            (0...arr_len).each do |n|
                if prc.call(self[n], self[n+1]) == 1
                    self[n], self[n+1] = self[n+1], self[n]
                    sorted = false
                end
            end
        end
        self

    end
end
