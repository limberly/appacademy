def first_anagram?(string1, string2)
    pers = string1.split("").permutation.to_a
    s2 = string2.split("")
    pers.each {|sub| return true if sub == s2}
    false
end

puts first_anagram?("gizmo", "sally")    #=> false
puts first_anagram?("elvis", "lives")    #=> true

def second_anagram?(s1, s2)
    s2_a = s2.split("")
    s1.each_char.with_index do |c1, id1|
        found = s2_a.find_index(c1)
        s2_a.delete_at(found) if found
    end
    return true if s2_a.empty?
    false
end

puts second_anagram?("gizmo", "sally")    #=> false
puts second_anagram?("elvis", "lives")    #=> true

def third_anagram?(s1, s2)
    s1_a_sorted = s1.split("").sort
    s2_a_sorted = s2.split("").sort
    return true if s1_a_sorted == s2_a_sorted
    false
end

puts third_anagram?("gizmo", "sally")    #=> false
puts third_anagram?("elvis", "lives")    #=> true

def fourth_anagram?(s1, s2)
    h = Hash.new {|h, k| h[k] = 0}
    s1.each_char {|c| h[c] += 1}
    s2.each_char {|c| h[c] -= 1}
    h.each_value {|v| return false if v != 0}
    true
end

puts fourth_anagram?("gizmo", "sally")    #=> false
puts fourth_anagram?("elvis", "lives")    #=> true