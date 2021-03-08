class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14)
    place_stones
    @name1 = name1
    @name2 = name2
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index {|array, i| (i == 6 || i == 13) ? @cups[i] = [] : @cups[i] = Array.new(4, :stone)}
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if @cups[start_pos].nil?
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    count = @cups[start_pos].count
    @cups[start_pos].clear
    ending_position = add_stones(count, start_pos, current_player_name)
    render
    next_turn(ending_position)
  end

  def add_stones(count, start_pos, current_player_name)
    next_position = start_pos
    1.upto(count) do |add|
      next_position = (next_position + 1) % 14
      case current_player_name
      when @name1
        next_position = skip_opponent_score(next_position, 13)
        @cups[next_position] << :stone
      when @name2
        next_position = skip_opponent_score(next_position, 6)
        @cups[next_position] << :stone
      end
    end
    next_position
  end

  def skip_opponent_score(next_position, opponent_score_position)
    if next_position == opponent_score_position
      next_position = (next_position + 1) % 13
    else
      next_position
    end
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    e = ending_cup_idx
    stone_count = @cups[e].count
    return :prompt if e == 13 || e == 6
    return :switch if stone_count == 1
    return e if stone_count > 1
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    top = (7..12).all? {|id| @cups[id].empty?}
    bottom = (0..5).all? {|id| @cups[id].empty?}
    return true if top || bottom
    false
  end

  def winner
    player1_score = @cups[6].count
    player2_score = @cups[13].count
    case player1_score <=> player2_score
    when -1
      @name2
    when 0
      :draw
    when 1
      @name1
    end
  end
end
