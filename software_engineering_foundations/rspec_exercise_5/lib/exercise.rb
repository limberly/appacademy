require 'byebug'
def zip(*arr)
    new_arr = Array.new(arr[0].length) {[]}
    arr.each do |subarray|
        subarray.each_with_index do |ele, id|
        new_arr[id] << ele
        end
    end
    new_arr
end

def prizz_proc(arr, prc1, prc2)
    arr.select do |n|
        prc1true = prc1.call(n)
        prc2true = prc2.call(n)
        (prc1true || prc2true) && !(prc1true && prc2true)
    end
end

def zany_zip(*arr)
    maximum = arr.inject(0) do |max, sub|
        if sub.length > max
            sub.length
        else
            max
        end
    end
    new_arr = Array.new(maximum) {[]}
    arr.each do |sub|
        maximum.times do |n|
            new_arr[n] << sub[n]
        end
    end
    new_arr
end

def maximum(arr, &prc)
    return nil if arr.empty?
    arr.inject(arr[0]) do |max, ele|
        previous_block = prc.call(max)
        current_block = prc.call(ele)
        current_block >= previous_block ? max = ele : max
    end 
end

def my_group_by(arr, &prc)
    hash = Hash.new {|h, k| h[k] = []}
    arr.each do |n|
        result = prc.call(n)
        hash[result] << n
    end
    hash
end

def max_tie_breaker(arr, prc1, &prc2)
    return nil if arr.empty?
    hash = Hash.new {|h, k| h[k] = []}
    arr.each do |ele|
        block = prc2.call(ele)
        hash[block] << ele
    end
    largest = hash.sort[-1][1]
    if largest.length > 1
        tied_hash = Hash.new {|h, k| h[k] = []}
        largest.each do |ele|
            proc = prc1.call(ele)
            tied_hash[proc] << ele
        end
        return tied_hash.sort[-1][1][0]
    end
    largest[0]
end

def silly_syllables(sent)
    new_w = []
    words = sent.split(" ")
    words.each do |w|
        if count_vowels(w) < 2
            new_w << w
        else
            new_w << before_after(w)
        end
    end
    new_w.join(" ")
    
end

def before_after(word)
    vowels = 'aeiouAEIOU'
    first = nil
    second = nil
    word.each_char.with_index do |c, id|
        if vowels.include?(c)
            first = id
            break
        end
    end

    word.reverse.each_char.with_index do |c, id|
        if vowels.include?(c)
            second = c
            break
        end
    end
    second = word.rindex(second)
    word[first..second]
end

def count_vowels(word)
    vowels = "aeiouAEIOU"
    count = 0
    word.each_char {|c| count += 1 if vowels.include?(c)} 
    count
end