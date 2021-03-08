require "byebug"
def palindrome?(str)
    sl = str.length - 1
    half = sl / 2 + 1
    (0...half).each do |n|
        return false if str[n] != str[sl - n]
    end
    return true
end

def substrings(str)
    arr = []
    str_len = str.length - 1
    (0..str_len).each do |e1|
        (e1..str_len).each do |e2|
            arr << str[e1..e2]
        end
    end
    return arr
end

debugger
def palindrome_substrings(str)
    return substrings(str).select {|subs| palindrome?(subs) && subs.length > 1}
end

puts palindrome_substrings("abracadabra")