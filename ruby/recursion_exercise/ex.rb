require 'byebug'

def range_iter(starting, ending)
    return [] if ending < starting
    new_arr = []

    (starting..ending).each do |n|
        new_arr << n
    end
    new_arr
end

def range_recur(starting, ending)
    return [] if ending < starting
    return [] if starting == ending
    new_arr = []
    new_arr + [starting] + range_recur(starting + 1, ending)
end

def exp1(b, e)
    return 1 if e == 0
    b * exp1(b, e - 1)
end

def exp2(b, e)
    return 1 if e == 0
    return b if e == 1

    if e.even?
        exp2(b, e/2) * exp2(b, e/2)
    else
        b * exp2(b, (e - 1)/2) * exp2(b, (e - 1)/2)
    end
end


class Array

    def deep_dup
        return [] if self.empty?
        new_arr = []
        self.each do |sub|
            if sub.is_a? Array
                new_arr << sub.deep_dup
            else
                return new_arr += self.clone
            end
        end
        new_arr
    end

end


def fib_recur(n)
    return [] if n < 1
    return [1] if n == 1
    return [1, 1] if n == 2
    new_arr = []
    new_arr = new_arr + fib_recur(n-1)
    new_arr += [new_arr[-1] + new_arr[-2]]
end

def fib_iter(n)
    return [] if n < 1
    return [1] if n == 1
    return [1, 1] if n == 2
    
    new_arr = [1, 1]
    until new_arr.length == n
        new_arr += [new_arr[-1] + new_arr[-2]]
    end
    new_arr
end

def bsearch(array, target)
    arr_len = array.length
    if arr_len.even?
        half_point = (arr_len / 2) - 1
    else
        half_point = arr_len / 2
    end

    value = array[half_point]
    begin
        case
        when value == target 
            return half_point
        when value > target
            return bsearch(array[0...half_point], target)
        when value < target
            return half_point + bsearch(array[(half_point + 1)..-1], target) + 1
        end
    rescue NoMethodError
        return nil
    rescue TypeError
        return nil
    end
end

def merge_sort(array)
    arr_len = array.length
    return array if arr_len == 1
    half_point = arr_len / 2
    left = array[0...half_point]
    right = array[half_point..-1]
    merge(merge_sort(left), merge_sort(right))
end

def merge(a1, a2)
    merged = []
    while !(a1.empty? && a2.empty?)
        if a1.empty? && !a2.empty?
            merged << a2.shift
        elsif !a1.empty? && a2.empty?
            merged << a1.shift
        elsif a1[0] < a2[0]
            merged << a1.shift
        elsif a1[0] > a2[0]
            merged << a2.shift
        end
    end
    merged
end 

def subsets(arr)
    return [] if arr.empty?
    arr_len = arr.length
    return [arr] if arr_len == 1
    new_arr = [[]]
    arr.each do |sub|

        new_arr += subsets([sub])
        new_len = new_arr.length
        if new_len > 2
            
            (1...new_len - 1).each do |n|
                new_new_arr = []
                new_new_arr += new_arr[n]
                new_new_arr += new_arr[new_len - 1]
                new_arr << new_new_arr
            end
        end
    end
    new_arr

end

def permutations(arr)
    arr_len = arr.length - 1
    permute(arr, 0, arr_len)
end

def permute(arr, i, n)
    # debugger
    return arr if i == n
    pers = []    
    (i..n).each do |m|
        arr[m], arr[i] = arr[i], arr[m]
        pers << permute(arr.clone, i + 1, n)
        arr[m], arr[i] = arr[i], arr[m]
    end
    pers
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
    return [] if amount == 0
    coins.each do |c|
        minus = amount - c
        if minus >= 0
            return [c] + greedy_make_change(minus, coins)
        end
    end
end

def make_better_change(amount, coins = [25, 10, 5, 1])
    return [] if amount == 0
    best_change = nil
    coins.each do |coin|
        next if coin > amount
        change_for_rest = make_better_change(amount - coin, coins)
        change = [coin] + change_for_rest
        if best_change.nil? || change.length < best_change.length
            best_change = change
        end
    end
    best_change
end
