require 'byebug'
class Array
    def my_each(&prc)
        self.length.times {|e| prc.call(self[e])}
        return self
    end

    def my_select(&prc)
        new_arr = []
        self.my_each do |e|
            new_arr << e if prc.call(e) == true
        end
        new_arr
    end

    def my_any?(&prc)
        self.my_each do |e|
            return true if prc.call(e) == true
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |e|
            return false if prc.call(e) != true
        end
        true
    end

    def my_flatten
        # debugger
        return [] if self.empty?
        return [self] if !(self.is_a? Array)
        arr = []
        ele = self.shift
        if !(ele.is_a? Array)
            arr << ele
        end
        if ele.is_a? Array
            arr.concat(ele.my_flatten)
        end
        arr.concat(self.my_flatten)
        arr
    end
    def my_zip(*args)
        # debugger
        array_to_return = []
        self_array_length = self.length
        number_of_arguments = args.length
        all_array = [self]
        (0...number_of_arguments).each do |i|
            all_array << args[i]
        end

        (0...self_array_length).each do |i|
            elements_from_each_args = []
            all_array.each do |arr|
                if arr[i]
                    elements_from_each_args << arr[i]
                else
                    elements_from_each_args << nil
                end
            end
            array_to_return << elements_from_each_args
        end
        array_to_return
    end

    def my_rotate(num = 1)
        array_length = self.length
        rotated_array = self.map.with_index do |n, id|
            new_index = (id + num) % array_length
            new_value = self[new_index]
            new_value
        end
        rotated_array
    end

    def my_join(str="")
        new_string = ""
        self.each {|c| new_string << c + str}
        if str != ""
            new_string.chop
        else
            new_string
        end
    end

    def my_reverse
        array_length = self.length
        new_array = []
        -1.downto(-array_length).each {|n| new_array << self[n]}
        new_array
    end
end
