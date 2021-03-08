require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'humanplayer.rb'
require_relative 'computerplayer.rb'
require 'byebug'
class Game
    def initialize(player)
        @board = Board.new
        @board.populate
        @previous_guess = nil
        @player = player        
        # if player == 'computer'
        #     @player = ComputerPlayer.new(5)
        # else
        #     @player = HumanPlayer.new(5)
        # end
    end

    def play
        until @board.won?
            @board.render
            user_guess = ask_until_valid_input
            
            make_guess(user_guess)
        end
    end

    def ask_until_valid_input
        user_input = @player.get_user_input(@previous_guess)
        board_positions = @board.get_board_indices
        board_positions_string = board_positions.map {|position| position.join.to_s}
        while true
            if !board_positions_string.include?(user_input)
                user_input = @player.get_user_input(@previous_guess)
            else
                return user_input.split("").map!(&:to_i)
            end
        end
    end

    def make_guess(pos)
        # debugger
        current_card = @board[pos].value 
        if current_card != ""
            puts "This card is already face up"
            sleep(2)
            return
        else
            @board[pos].reveal
            # if !@player.human
                @player.receive_revealed_card(pos, @board[pos].value)
            # end
            current_card = @board[pos].value 
        end

        if @previous_guess
            previous_card = @board[@previous_guess].value


            if @previous_guess == pos
                puts "You cannot type the same position\n"
                sleep(2)
                return
            elsif previous_card != current_card
                @board.reveal(pos)
                sleep(1)
                @board[pos].hide
                @board[@previous_guess].hide
                @previous_guess = nil
                return

            elsif previous_card == current_card
                # if !@player.human
                    @player.receive_match(@previous_guess, pos, current_card)
                # end
                @previous_guess = nil
                return
            end
        end
        @previous_guess ||= pos
        @board.reveal(pos)
    end
end

if __FILE__ == $PROGRAM_NAME

    # HumanPlayer.new(5)
    game = Game.new(HumanPlayer.new(5))
    game.play
end