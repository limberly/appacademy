require 'byebug'

def my_min(l)
    #O(n^2)
    l.each_with_index do |e1, id1|
        all_bigger = true
        l.each_with_index do |e2, id2|
            unless id1 == id2
                all_bigger = false if e1 > e2
            end
        end
        return e1 if all_bigger == true
    end
end

def my_min2(l)
    #O(n)
    min = l[0]
    l.each {|e| min = e if e < min}
    min
end

def largest_contiguous_subsum(list)
    max = list 
    list.each_with_index do |e1, id1|
        list.each_with_index do |e2, id2|
            current = list[id1..id2]
            max = current if id1 <= id2 && max.sum < current.sum
        end
    end
    max.sum
end

def largest_contiguous_subsum2(list)
    current = list.first
    largest = list.first
    li_len = list.length

    (1...li_len).each do |i|
        debugger
        current = 0 if current < 0
        current += list[i]
        largest = current if current > largest
    end
    largest

end

list = [5, 3, -7]
pp largest_contiguous_subsum(list)

list = [2, 3, -6, 7, -6, 7]
pp largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

list = [-5, -1, -3]
pp largest_contiguous_subsum(list) # => -1 (from [-1])

list = [5, 3, -7]
pp largest_contiguous_subsum2(list)

list = [2, 3, -6, 7, -8, 9]
pp largest_contiguous_subsum2(list) # => 8 (from [7, -6, 7])

list = [-5, -1, -3]
pp largest_contiguous_subsum2(list) # => -1 (from [-1])