require 'byebug'
require_relative 'card.rb'
class Board
    def initialize
        @board = Array.new(4) {Array.new(4) {Card.new}}
    end

    def render
        system("clear")
        @board.each_with_index do |subarray, id1|
            if id1 == 0
                print "\t0\t1\t2\t3\n\t* * * * * * * * * * * * *\n"
            end
            print id1, " *"
            subarray.each_with_index do |elements, id2|
                print "\t", elements.value
            end
            print "\n  *\n" unless id1 == 3
        end
        puts "\n---------------------------------\n"
    end

    def populate
        where_cards_are_placed_on_board = get_cards
        # debugger
        where_cards_are_placed_on_board.each do |card, board_position|
            first_card = self[board_position[0]]
            second_card = self[board_position[1]]
            first_card.value, second_card.value = card, card
        end
    end
    #-------------------------------------------------------
    #Used for #populated
    def get_board_indices
        board_length = @board.length
        indices = []
        board_length.times do |row|
            board_length.times do |column|
                indices << [row, column]
            end
        end
        number_of_indices = board_length * board_length
        return indices.sample(number_of_indices)
    end

    def get_cards
        board_indices = get_board_indices
        cards = 'ABCDEFGH'.split("")
        cards_indices = Hash.new {|h,k| h[k] = []}
        cards.each do |c|
            2.times do |n|
                cards_indices[c] << board_indices.shift
            end
        end
        return cards_indices
    end
    
    def [](board_position)
        @board[board_position[0]][board_position[1]]
    end
    #Used for populate
    #-------------------------------------------------------

    def won?
        all_cards_open = @board.all? do |array|
            array.all? do |cards|
                cards.value != ""
            end
        end
        if all_cards_open
            self.render
            puts "You won!"
            return true
        end
        
    end

    def reveal(guessed_pos)
        chosen_card = self[guessed_pos]
        chosen_card.reveal
        self.render
        chosen_card.value
    end

end
