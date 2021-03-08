require_relative 'tile.rb'
require 'byebug'
class Board
    def self.from_file(filepath)
        begin
            file = File.open(filepath)
        rescue
            puts "Not a valid file"
        else
            puts "file #{filepath} read successfully"
        end
        board = Array.new(9) {Array.new}
        row_number = 0
        file.readlines.each do |line|
             line.chomp.each_char do |value|
                if value != "0"
                    board[row_number] << Tile.new(value.to_i, true)
                else
                    board[row_number] << Tile.new
                end
             end
             row_number += 1
        end
        file.close
        board
    end

    def initialize(filepath)
        @board = Board.from_file(filepath)
        @nums = {}
        (1..9).each {|n| @nums[n] = 0}
        @number_range = @nums.keys
    end

    def render
        @board.each do |row|
            row.each do |col|
                col.to_s
            end
            puts
        end
        puts "---------------"
    end

    def []=(position, value)
        @board[position[0]][position[1]].value = value
    end


    def solved?
        # @board.each {|row| puts row_solved(row)}
        return false if !(@board.all? {|row| row_solved(row)})
        self.transpose
        return false if !(@board.all? {|col| row_solved(col)})
        self.transpose
        return false if !(self.block_solved)
        return true
    end

    def row_solved(row)
        values = []
        row.each do |e|
            values << e.value
            return false if !@number_range.include?(e.value)
        end
        return false if values.length != values.uniq.length
        true
    end

    def col_solved(col)
        values = []
        col.each do |e|
            values << e.value
            return false if !@number_range.include?(e.value)
        end
        return false if values.length != values.uniq.length
        true
    end

    def block_solved
        blocks_to_check = [[1,1], [1,4], [1,7], [4,1], [4,4], [4,7], [7,1], [7,4], [7,7]]
        blocks_to_check.any? do |pos|
            block = []
            block = get_surround(pos)
            row_solved(block)
        end
    end

    def get_surround(pos)
        row = pos[0]
        col = pos[1]
        surround_array = []
        surround = [-1, 0, 1]
        surround.each do |e1|
            surround.each do |e2|
                surround_array << @board[row + e1][col + e2]
            end
        end
        surround_array
    end

    def transpose
        @board = @board.transpose
    end
end

# board = Board.new('puzzles/sudoku1_almost.txt')
# p board.solved?