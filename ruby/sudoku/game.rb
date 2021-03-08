require_relative 'board.rb'

class Game
    def initialize(filepath)
        @board = Board.new(filepath)
    end

    def play
        until @board.solved?
            @board.render
            pos, value = user_input
            @board[pos] = value
        end
        @board.render
        puts "You won!"
    end

    def user_input
        pos = get_position
        value = get_value
        return pos, value
    end

    def get_position
        puts "Type board position ex. 01 for row 0 column 1"
        pos = gets.chomp

        while pos.length != 2
            puts "Type board position ex. 01 for row 0 column 1"
            pos = gets.chomp
        end
        return pos = pos.split("").map(&:to_i)
    end

    def get_value
        puts "Type a number between 1-9 to place on that position"
        value = gets.chomp
        while value.length != 1
            puts "Type a number between 1-9 to place on that position"
            value = gets.chomp
        end
        value = value.to_i
        return value
    end

end