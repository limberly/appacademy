class Array
    def my_uniq
        self.inject([]) {|new_arr, ele| new_arr.include?(ele) ? new_arr : new_arr.push(ele)}
    end    

    def two_sum
        positions = []
        self.each_with_index do |e1, id1|
            self.each_with_index do |e2, id2|
                next if id2 < id1
                unless id1 == id2
                    positions << [id1, id2] if e1 + e2 == 0
                end
            end
        end
        positions.sort do |a, b|
            if a[0] == b[0]
                a[1] <=> b[1]
            else
                a[0] <=> b[0]
            end
        end
    end
end

public

def my_transpose(arr)
    given_matrix_size = arr.length
    transposed_matrix = Array.new(given_matrix_size) {Array.new}
    arr.each do |row|
        row.each_with_index do |col, id|
            transposed_matrix[id] << col
        end
    end
    transposed_matrix
end

