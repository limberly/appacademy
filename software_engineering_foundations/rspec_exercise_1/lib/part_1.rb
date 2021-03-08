def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum(0.0) / arr.length
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(str)
    str = str.downcase.split(" ").each_with_index.map do |e, i|
        if i % 2 == 0
            e.upcase
        else
            e
        end
    end
    str.join(" ")
end