def partition(arr, num)
    parted = [[], []]

    arr.each {|e| (e < num) ? parted[0] << e : parted[1] << e}
    return parted
end

def merge(hash1, hash2)
    hash3 = hash1.clone

    hash2.each do |key, value|
        hash3[key] = value
    end
    return hash3

end

def censor(sentence, array)
    words = sentence.split(" ")
    vowels = "aeiou"

    words.map! do |word|
        censored = ""
        
        if array.include?(word.downcase)
            word.each_char {|c| vowels.include?(c.downcase) ? censored << "*" : censored << c} 
            word = censored
        else
            word
        end
    end

    return words.join(" ")  
end

def power_of_two?(num)
    
    return false if num <= 0

    while true
        return true if num == 1
        return false if num % 2 != 0
        num /= 2
    end
end