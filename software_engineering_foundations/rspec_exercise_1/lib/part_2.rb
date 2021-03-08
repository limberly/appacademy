def hipsterfy(word)
    vowel = "aeiou"
    wl = word.length - 1

    new_word = ""
    counted = false
    (0..wl).reverse_each do |id|
        if counted ==  false && vowel.include?(word[id])
            counted = true
        else
            new_word << word[id]
        end
    end
    new_word.reverse!
    
end

def vowel_counts(str)
    str_hash = Hash.new(0)
    vowel = "aeiou"
    str = str.downcase
    str.each_char {|c| str_hash[c] += 1 if vowel.include?(c)}
    return str_hash
end

def caesar_cipher(message, number)
    alpha = "abcdefghijklmnopqrstuvwxyz"
    alpha_up = alpha.upcase
    alpha_len = alpha.length
    new_message = message.each_char.map do |e|
        if alpha_up.include?(e)
            alpha_up[((alpha_up.index(e)+ number) % alpha_len)]
        elsif alpha.include?(e)
            alpha[((alpha.index(e) + number) % alpha_len)]
        else
            e
        end
    end
    return new_message.join("")
end

puts caesar_cipher("zebra", 4)