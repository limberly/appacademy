def sum_to(n)
    return nil if n < 1
    return 1 if n == 1
    n + sum_to(n-1)
end

def add_numbers(arr)
    return arr[0] if arr.length == 1
    return nil if arr.length < 1
    arr[0] + add_numbers(arr[1..-1])
end

def gamma_fnc(n)
    return 1 if n == 1
    return nil if n < 1
    (n - 1) * gamma_fnc(n - 1)
end

def ice_cream_shop(flavors, favorite)
    return false if flavors.empty?
    exist = flavors[0] == favorite
    if !exist
        return ice_cream_shop(flavors[1..-1], favorite)
    end
    return exist
end

def reverse(str)
    return str if str == ""
    str[-1] + reverse(str[0...-1])
end
