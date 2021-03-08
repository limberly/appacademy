def element_count(arr)
    arr_to_hash = Hash.new(0)
    arr.each {|n| arr_to_hash[n] = arr.count(n)}
    arr_to_hash
end

def char_replace!(str, hs)
    str.each_char.with_index do |c, id|
        value = hs[c]
        if value
            str[id] = value
        end
    end
    str
end

def product_inject(arr)
    arr.inject {|prod, number| prod * number}
end