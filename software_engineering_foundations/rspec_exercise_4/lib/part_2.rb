def proper_factors(number)
    proper = []

    (1...number).each do |n|
        proper << n if number % n == 0
    end
    proper
end

def aliquot_sum(number)
    proper_factors(number).sum
end

def perfect_number?(number)
    number == aliquot_sum(number)
end

def ideal_numbers(n)
    perfects = []
    number = 0
    while perfects.length < n
        number += 1
        perfects << number if perfect_number?(number)
    end
    perfects
end