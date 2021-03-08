require 'set.rb'
class ComputerPlayer
    attr_reader :human
    def initialize(size)
        @size = size
        @copy_board = Board.new
        @human = false
        @board_positions_to_guess = @copy_board.get_board_indices
        @match = Hash.new {|h, k| h[k] = []}
        @opened = Hash.new {|h, k| h[k] = []}
        @match_to_open = []
    end

    def get_user_input(previous_guess)
        # debugger
        card, positions = self.seen_match

        if card != nil
            matched_card = already_match(card)
            if !matched_card
                positions.delete_if {|position| position == previous_guess}
                @match_to_open += positions
                @opened.delete(card)
            end
        end

        if !@match_to_open.empty?
            computer_input = @match_to_open[0]
            @match_to_open = @match_to_open.drop(1)
            return computer_input.join
        end

        if card == nil
            @match_to_open = []
            choose = @board_positions_to_guess.sample.join
            return choose
        end
    end

    def seen_match
        @opened.each do |k, v|
            return k, v if v.length == 2
        end
        return nil
    end

    def already_match(match)
        if @match[match].sort == @opened[match].sort
            @opened.delete(match)
            return true
        else
            return false
        end
    end

    def receive_revealed_card(pos, card)
        @copy_board[pos].value = card
        @opened[card] << pos
        @board_positions_to_guess.delete_if {|position| position == pos}
    end


    def receive_match(previous_position, current_position, card_value)
        @match[card_value].push(previous_position, current_position)
        @board_positions_to_guess.delete(previous_position)
        @board_positions_to_guess.delete(current_position)
    end

end