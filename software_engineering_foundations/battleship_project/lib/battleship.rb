require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player
  def initialize(n)
      @player = Player.new
      @board = Board.new(n)
      @remaining_misses = board.size / 2
  end

  def start_game
      @board.place_random_ships
      puts @board.num_ships
      puts @board.print  
  end

  def lose?
    if @remaining_misses > 0
        false
    else
        print 'you lose'
        true
    end
  end

  def win?
      ships = @board.num_ships
      if ships == 0
        print 'you win'
        true
      else
        false
      end
  end

  def game_over?
    lose? || win?
  end

  def turn
      move = @player.get_move
      success = @board.attack(move)
      @board.print
      if !success
        @remaining_misses -= 1
      end
      puts @remaining_misses
  end
end
