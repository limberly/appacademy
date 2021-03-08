require_relative 'game.rb'

if ARGV.length != 1
    puts "Type valid path to sudoku puzzle file"
    exit!
end

p ARGV[0]

game=Game.new(ARGV[0])
ARGV.clear
game.play