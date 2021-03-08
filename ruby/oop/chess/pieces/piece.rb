class Piece
    attr_accessor :pos
    attr_reader :board, :color
    def initialize(color, board, pos)
        raise "invalid color" unless %i(white black).include?(color)
        raise "invalid pos" unless board.valid_pos?(pos)
    
        @color, @board, @pos = color, board, pos
    
        board.add_piece(self, pos)
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        false
    end

    def symbol
        raise NotImplementedError
    end

    def valid_moves
        
    end

    def move_into_check?(end_pos)
        
    end

end