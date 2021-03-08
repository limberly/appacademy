# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require 'byebug'

def prime?(num)
    return false if num < 2
    (2...num).none? {|n| num % n == 0}
end

def largest_prime_factor(num)
    num.downto(2) {|factor| return factor if num % factor == 0 && prime?(factor)}
end

def unique_chars?(str)
    str.each_char do |c|
        if str.count(c) > 1
            return false
        end
    end
    return true
    
end

def dupe_indices(arr)
    repeats = Hash.new {|h, v| h[v] = []}
    arr.each_with_index {|h, v| repeats[h] << v}
    repeats.select {|h, v| v.length > 1}
end

def ana_array(arr1, arr2)
    if arr1.length > arr2.length
        arr1.each do |e|
            return false if arr1.count(e) != arr2.count(e)
        end
    else
        arr2.each do |e|
            return false if arr2.count(e) != arr1.count(e)
        end
    end
    return true

end