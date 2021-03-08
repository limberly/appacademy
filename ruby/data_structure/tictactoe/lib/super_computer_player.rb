require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    g = TicTacToeNode.new(game, mark)
    # debugger
    alternate = (mark == :o ? :x : :o)
    winning = g.children.select {|child| child.winning_node?(mark) && !child.winning_node?(alternate)}
    return winning[0].prev_move_pos if !winning.empty?
    not_losing = g.children.select {|child| child.losing_node?(alternate) && !child.losing_node?(mark)} 
    return not_losing[0].prev_move_pos if !not_losing.empty?
    draw = g.children.select {|child| child.draw?}
    raise "can't find any mvoes" if winning.empty? && not_losing.empty? && draw.empty?
    one_win = g.children.map {|child| child.children.select {|c| c.board.winner == alternate}}.flatten
    return one_win[0].prev_move_pos if !one_win.empty?

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
