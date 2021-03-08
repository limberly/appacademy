require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  attr_writer :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.over? && (@board.winner != evaluator) && (@board.winner != nil)
    return false if @board.over? && ((@board.winner == evaluator) || (@board.winner == nil))
    
    children.any? do |child|
      child.losing_node?(evaluator)
    end
    
  end

  def winning_node?(evaluator)
    return true if @board.over? && (@board.winner == evaluator)
    return false if @board.over? && (@board.winner != evaluator)
    children.any? do |child|
      child.winning_node?(evaluator)
    end
  end

  def draw?
    return true if @board.over? && (@board.winner == nil)
    return false if @board.over? && (@board.winner != nil)
    children.any? do |child|
      child.draw?  
    end
  end
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes = []
    (0..2).each do |row|
      (0..2).each do |col|
        if @board.empty?([row, col])
          duplicate = @board.dup
          duplicate[[row, col]] = @next_mover_mark
          child = TicTacToeNode.new(duplicate, alternate_marker(@next_mover_mark), [row, col])
          nodes << child
        end
      end
    end
    nodes
  end

  def alternate_marker(marker)
      return :o if marker == :x
      :x
  end
end
