require 'byebug'
class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) {Array.new(n, :N)}
    @size = n*n
    @idx = []
    (0...n).each do |e1|
        (0...n).map {|e2| @idx << [e1, e2]}
    end

  end

  def [](position)
      @grid[position[0]][position[1]]
  end

  def []=(position, value)
      @grid[position[0]][position[1]] = value
  end

  def num_ships
      ships = @grid.inject(0) {|counted, sub| counted += sub.count {|e| e == :S}}
      ships
  end

  def attack(position)
    
    if  self.[](position) != :S
        self.[]=(position, :X)
        return false
    end

    @grid[position[0]][position[1]] = :H
    puts "You sunk my battleship!"
    true
  end

  def place_random_ships
    quarter = @size / 4
    selection = @idx.sample(quarter)
    selection.each {|s| self.[]=(s, :S)}
  end

  def hidden_ships_grid
      
    hidden = @grid.map do |sub|
        sub.map do |e|
            if e == :S
                :N
            else
                e
            end
        end
    end
    hidden
  end

  def self.print_grid(grid_arr)
    new_grid = "/"
    grid_arr.each do |sub|
        sub.each do |e|
            new_grid << e.to_s + " "
        end
        new_grid.chop!
        new_grid << "\n"
    end
    new_grid << "/"
    print new_grid
  end

  def cheat
      Board.print_grid(@grid)
  end

  def print
      Board.print_grid(hidden_ships_grid)
  end
end

