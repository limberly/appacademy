def brute_force(arr, num)
    # O(n^2)
    arr.each_with_index do |e1, id1|
        arr.each_with_index do |e2, id2|
            unless id1 == id2
                return true if e1 + e2 == num
            end
        end
    end
    false
end


def sorted(arr, num)
    sorting = arr.sort
    arr.each_with_index do |e1, id1|
        break if e1 >= num
        arr.each_with_index do |e2, id2|
            break if e2 >= num
            unless id1 == id2
                return true if e1 + e2 == num
            end
        end
    end
    false
end

def with_hash(arr, num)
    h = Hash.new

    arr.each do |e|
        return true if h[num - e]
        h[e] = true
    end
    false
end

arr = [0, 1, 5, 7]
puts with_hash(arr, 6) # => should be true
puts with_hash(arr, 10) # => should be false

