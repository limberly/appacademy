require 'byebug'
def select_even_nums(arr)
    arr.select(&:even?)
end

def reject_puppies(hs)
    hs.reject {|h, v| h["age"] <=2}
end

def count_positive_subarrays(arr_2d)
    arr_2d.count {|arr| arr.sum > 0}
end

def aba_translate(str)
    vowel = 'aeiou'
    new_str = ""
    str.each_char do |c|
        if vowel.include?(c)
            new_str << (c + "b" + c)
        else
            new_str << c
        end
    end
    new_str
end

def aba_array(arr)
    arr.map {|word| aba_translate(word)}
end