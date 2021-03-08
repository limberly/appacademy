def reverser(str, &prc)
    str.reverse!
    prc.call(str)
end

def word_changer(sentence, &prc)
    words = sentence.split(" ")
    new_words = []
    words.each {|ele| new_words << prc.call(ele)}
    new_words.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    first = prc1.call(num)
    second = prc2.call(num)
    if first > second
        return first
    else
        return second
    end
end

def and_selector(arr, prc1, prc2)
    new_arr = []
    arr.each {|ele| new_arr << ele if prc1.call(ele) && prc2.call(ele)}
    new_arr
end

def alternating_mapper(arr, prc1, prc2)
    new_arr = []
    arr.each_with_index do |ele, id|
        if id.even?
            new_arr << prc1.call(ele)
        else
            new_arr << prc2.call(ele)
        end
    end
    new_arr
end