def is_prime?(number)
    (2...number).each do |n|
        return false if number % n == 0
    end
    return false if number < 2
    return true
end

def nth_prime(n)
    number = 1
    count_nth = 0
    while count_nth < n
        if is_prime?(number)
            count_nth += 1
            return number if count_nth == n
        end
        number += 1

    end
end

def prime_range(min, max)
    primes = []
    (min..max).each {|n| primes << n if is_prime?(n)}
    primes
end
