def strange_sums(arr)
    arrlen = arr.length - 1
    count = 0
    (0...arrlen).each do |n1|
        (n1..arrlen).each do |n2|
            count +=1 if (arr[n1] + arr[n2]) == 0
        end
    end
    count
end

def pair_product(arr, product)
    arr.each_with_index do |n1, id1|
        arr.each_with_index do |n2, id2|
            unless id1 == id2
                return true if (n1 * n2) == product
            end
        end
    end
    false
end

def rampant_repeats(str, hash)
    new_str = ""
    str.each_char.with_index do |c, id|
        value = hash[c]
        if value
            new_str += c*value
        else
            new_str += c
        end
    end
    new_str
end

def perfect_square(n)
    ((n**0.5).floor)**2 == n
end

