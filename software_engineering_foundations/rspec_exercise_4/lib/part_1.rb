def my_reject(arr, &prc)
    arr.select {|n| prc.call(n) == false}
end

def my_one?(arr, &prc)
    count = 0
    arr.each {|n| count += 1 if prc.call(n) == true}
    count == 1 ? true : false
end

def hash_select(hash, &prc)
    new_hash = {}
    hash.each {|k, v| new_hash[k] = v if prc.call(k, v) == true}
    new_hash
end

def xor_select(arr, prc1, prc2)
    new_arr = []
    arr.each do |n|
        prc1true = prc1.call(n)
        prc2true = prc2.call(n)
        if (prc1true || prc2true) && !(prc1true && prc2true)
            new_arr << n
        end
    end
    new_arr
end

def proc_count(value, arr)
    number_of_trues = 0
    arr.each do |prc|
        number_of_trues += 1 if prc.call(value) == true
    end
    number_of_trues
end