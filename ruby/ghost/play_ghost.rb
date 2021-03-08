require_relative 'ghost_multi.rb'

print "How many players?: "
number_of_players = gets.chomp.to_i
player_names = []
number_of_players.times do |player|
    print "Player #{player + 1} name: "
    player_names << gets.chomp
end
puts "-----------------"

game = Game.new(*player_names)
game.run