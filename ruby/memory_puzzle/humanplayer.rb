class HumanPlayer
    attr_reader :human
    def initialize(size)
        @size = size
        @human = true
    end

    def get_user_input(previous_guess)
        
        if previous_guess
            puts "Type second guess"
        else
            puts "Type first guess"
        end
        print "Type a position on the board ex. 01 for row 0, column 1: "
        gets.chomp        
    end

    def receive_revealed_card(pos, card)

    end


    def receive_match(previous_position, current_position, card_value)

    end

end