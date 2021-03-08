require 'set'
require 'byebug'
require_relative 'player.rb'

class Game
    GHOST = "GHOST"
    def initialize(player1_name, player2_name)
        @players = [Player.new(player1_name), Player.new(player2_name)]
        @fragment = ""
        @dictionary = Set.new({})
        @current_player = @players[0]
        @previous_player = @players[1]
        @losses = {}
        @players.each {|player| @losses[player.name] = ""}
        @round = 1
    end

    def load_dictionary
        file = 'ghost_dictionary.txt'
        File.readlines(file).each do |word|
            @dictionary.add(word.chomp)
        end
        true
    end

    def run
        self.load_dictionary
        until winner?
            puts "Round #{@round}"
            play_round
        end
    end

    def play_round
        self.display_score
        take_turn(@current_player)
        @round +=1 if self.lost?
        self.next_player!
    end

    def take_turn(player = @players[0])
        puts "-----------------"
        puts "#{player.name}'s turn"
        
        user_guess = player.guess
        while true
            if valid_play?(user_guess)
                @fragment += user_guess
                puts "#{player.name} made a valid move: #{@fragment}"
                puts "Word made so far: #{@fragment}"
                puts "-----------------"
                return true
            else
                puts "#{player.name} made invalid move: #{user_guess}. Choose a different letter"
                puts "-----------------"
                user_guess = player.guess
            end
        end

    end

    def valid_play?(string)
        guessed_word = @fragment + string
        @dictionary.any? {|vocab| vocab.start_with?(guessed_word)}
    end


    def lost?
        if @dictionary.include?(@fragment)
            current_player_name = @current_player.name
            puts "#{current_player_name} lost."
            @fragment = ""
            current_player_loss_length = @losses[current_player_name].length
            @losses[current_player_name] += GHOST[current_player_loss_length]
            if @losses[current_player_name].length == 5
                puts "GHOST! #{current_player_name} is out."
                puts "-----------------"
                @players.delete_if {|player| player.name == current_player_name}
            end
            
            return true
        end
        return false
    end

    def winner?
        if @players.length == 1
            puts "-----------------"
            puts "#{@current_player.name} won!"
            return true
        end
        return false
    end

    def next_player!
        @current_player, @previous_player = @previous_player, @current_player
    end

    def display_score
        puts "-----------------"
        puts "Score board"
        @losses.each {|k, v| puts "#{k}: #{v}"}
    end
end
# debugger
game = Game.new('kieu', 'linh')
game.run
