# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".
def compress_str(str)
    count = 0
    new_str = ""
    str_len = str.length - 1
    str.each_char.with_index do |c, id|
        if (id != str_len) && (c == str[id + 1])
            count += 1
        elsif c == str[id - 1]
            count += 1
            
            new_str << count.to_s + c
            
            count = 0

        else
            new_str << c
        end
    end

    return new_str


end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
