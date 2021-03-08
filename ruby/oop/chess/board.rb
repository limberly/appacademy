require_relative 'piece'
require 'byebug'

class NoPieceError < ArgumentError
    def message
        puts "There is no piece at the position"
    end
end

class InvalidMoveError < ArgumentError
    def message
        puts "Can't move to that position"
    end
end

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(8) {
            |i| (i > 1 && i < 6) ? Array.new(8,nil) : Array.new(8,Piece.new)
        }
    end

    def [](pos)
        raise "invalid pos" unless valid_pos?(pos)

        row, col = pos
        @rows[row][col]
    end

    def []=(pos, val)
        raise "invalid pos" unless valid_pos?(pos)

        row, col = pos
        @rows[row][col] = val
    end

    def add_piece(piece, pos)
        raise "position not empty" unless empty?(pos)

        self[pos] = piece
    end

    def empty?(pos)
        self[pos].empty?
    end

    def move_piece(start_pos, end_pos)
        raise "start position is empty" if empty?(start_pos)
        valid_end_position = valid_pos?(end_pos)
        if self[start_pos].nil?
            raise NoPieceError
        elsif !self[end_pos].nil? || !valid_end_position
            raise InvalidMoveError
        end
        self[start_pos], self[end_pos] = nil, self[start_pos]
    end

    def render
        puts "  " + ("0".."7").to_a.join(" ")
        @rows.each.with_index do |row, id|
            print "#{id}"
            row.each do |col|
                print " p" if !col.nil?
                print " n" if col.nil?
            end
            puts
        end
    end

    def valid_pos?(pos)
        pos.all? {|coord| coord.between?(0, 7)}
    end

end

b = Board.new
b.render
b.move_piece([0,0], [2,0])
b.render
# if $PROGRAM_NAME == __FILE__
#     b = Board.new
#     b.render
# end