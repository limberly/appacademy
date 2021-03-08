def no_dupes?(arr)
    arr_hash = Hash.new(0)
    arr.each {|e| arr_hash[e] += 1}
    no_dup = arr_hash.select {|k, v| v == 1}
    no_dup.keys
end

def no_consecutive_repeats?(arr)
    arr.each_with_index do |e, id|
        if e == arr[id + 1]
            return false
        end
    end
    return true
end

def char_indices(str)
    str_hash = Hash.new {|hash, key| hash[key] = []}

    str.each_char.with_index {|c, id| str_hash[c] << id}
    str_hash
end

def longest_streak(str)
    streak_hash = Hash.new(0)
    str_len = str.length - 1
    count = 0
    str.each_char.with_index do |c, id|
        if streak_hash[c] == 0
            count += 1
        end

        if streak_hash[id - 1] == c
            count += 1
        end

        if (str[id + 1] != c) && (count > streak_hash[c])
            streak_hash[c] = count
            count = 0
        end
    end

    long = streak_hash.inject do |longest, (k, v)|
        if v >= longest[1]
            longest = [k, v]
        else
            longest = longest
        end
    end
    long_str = ""
    long[1].times {long_str << long[0]}
    long_str

end

def bi_prime?(num)
    factors = []
    while num != 1
        2.upto(num).each do |f|
            if num % f == 0
                factors << f
                num /= f
                break
            end
        end
    end
    return false if factors.length > 2
    return factors.all? {|x| prime?(x)}
end

def prime?(n)
    (2...n).each {|p| return false if n % p == 0}
    true
end

def vigenere_cipher(message, keys)
    key_len = keys.length
    alpha = ("a".."z").to_a
    message = message.each_char.with_index.map do |c, id|
        move = keys[id % key_len]
        alpha[(alpha.index(c) + move) % 26]
    end
    message.join("")
end

def vowel_rotate(str)
    vowel_index = []
    vowel = "aeiou"
    str.each_char.with_index {|c, id| vowel_index << id if vowel.include?(c)}
    new_str = str.clone

    v_len = vowel_index.length - 1

    (0..v_len).each do |n|
        if n == 0
            new_str[vowel_index[n]] = str[vowel_index[-1]]
        else
            new_str[vowel_index[n]] = str[vowel_index[n-1]]
        end
    end
    new_str

end

class String
    def select(&prc)
        container = ""

        if prc
            self.each_char {|c| container << c if prc.call(c)}
        end
        container
    end

    def map!(&prc)
        self.each_char.with_index do |c, id|
            self[id] = prc.call(c, id)
        end
        self
    end
end

def multiply(a, b)
    return 0 if b == 0 || a == 0
    base = 0
    sign = (b <=> 0)
    b  -= sign
    if (a > 0) && (sign == 1)    
        a + multiply(a, b)
    elsif (a < 0) && (sign == -1)
        -a + multiply(a, b)
    elsif (a < 0)
        a + multiply(a, b)
    elsif (a > 0)
        -a + multiply(a, b)
    end
end

def lucas_sequence(num)
    return [] if num == 0
    return [2] if num == 1
    return [2, 1] if num == 2
    added = lucas_sequence(num - 1)
    added << added[-2] + added[-1]
    added
    
end

def prime_factorization(num)
    return [] if num == 1
    fac = []
    (2..num).each do |n|
        if prime?(n) && (num % n == 0)
            fac.unshift(prime_factorization(num / n))
            return fac.unshift(n).flatten!
        end
    end
end