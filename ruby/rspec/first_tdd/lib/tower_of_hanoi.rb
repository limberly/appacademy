require 'byebug'

class Hanoi
    attr_reader :board
    def initialize(board = nil)
        @board = board
        @board ||= Array.new(5) {Array.new(3) {Array.new}}
    end

    def populate_discs
        disc_number = 0
        5.times do |n|
            disc_number += 1
            @board[n][0] << disc_number
        end
    end

    def [](pos)
        @board[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @board[pos[0]][pos[1]] = value
    end

    def move(start_pos, end_pos)
        row_below_end_pos = [end_pos[0] + 1, end_pos[1]]
        if row_below_end_pos[0] < 5
            if ((self[row_below_end_pos].empty?) ||
                (self[row_below_end_pos][0] < self[start_pos][0]))
                raise "Invalid move"
            end
        end

        row_above_start_pos = [start_pos[0] - 1, start_pos[1]]
        if start_pos[0] > 0
            raise "Invalid move" if !self[row_above_start_pos].empty?
        end    

        raise "Invalid move" if !self[end_pos].empty?

        self[end_pos] = self[start_pos].clone
        self[start_pos].clear
    end

    def valid_pos?(pos)
        raise "Not a valid position" unless (pos.length == 2) && pos[0].between?(1,5) && pos[1].between?(1,3)
        true
    end

    def get_user_input
        begin
            puts "Enter starting position. ex 1,2"
            start_pos = gets.chomp.split(",").map(&:to_i)
            valid_pos?(start_pos)
            puts "Enter ending position. ex 1,2"
            end_pos = gets.chomp.split(",").map(&:to_i)
            valid_pos?(end_pos)
        rescue
            puts "Invalid position"
            retry
        end            
        return start_pos, end_pos
    end

    def won?
        winning_state = [
            [[], [], [1]],
            [[], [], [2]],
            [[], [], [3]],
            [[], [], [4]],
            [[], [], [5]]
        ]
        return true if @board == winning_state
        return false
    end

    def render
        puts "  " + ("1".."3").to_a.join("  ")
        @board.each_with_index do |sub, id|
            print "#{id + 1}"
            sub.each {|e| print " #{e}"}
            puts
        end
    end

    def play
        populate_discs
        until won?
            begin
            system("clear")
            render
            start_pos, end_pos = get_user_input
            start_pos[0], start_pos[1] = start_pos[0]- 1, start_pos[1] - 1
            end_pos[0], end_pos[1] = end_pos[0]- 1, end_pos[1] - 1
            move(start_pos, end_pos)
            rescue
                puts "Can't do that"
                sleep(1)
                retry
            end
        end
        puts "you won!"
    end
end

if $PROGRAM_NAME == __FILE__
    game = Hanoi.new
    game.play
end