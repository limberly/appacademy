require_relative 'card'

class Player
    attr_reader :hand, :pot, :name

    def initialize(name, hand = Card.new)
        @name = name
        @hand = hand
        @pot = 100
    end

    def show_hands
       puts @hand.cards
    end

    def user_input
        choice = ['see', 'fold', 'raise', 'discard']
        begin
            user_choice = gets.chomp
            raise ArgumentError if !choice.include?(user_choice)
        rescue
            puts "Invalid choice"
            retry
        end
        user_choice
    end
    
    def discard
        hands = ("1".."5").to_a
        begin
            puts "Enter up to 3 cards to discard. ex, 123"
            user_input = gets.chomp.split("")
            raise ArgumentError if user_input.length > 3
            card_to_discard = user_input.map do |c|
                raise ArgumentError if !hands.include?(c)
                c.to_i
            end
        rescue
            puts "Invalid selection"
            retry
        end
        card_to_discard.each {|n| @hand.cards.delete_at(n - 1)}
    end

    def bet
        available_amount = ("1"..@pot.to_s).to_a
        begin
            puts "Enter amount to bet"
            betting_amount = gets.chomp
            raise ArgumentError if !available_amount.include?(betting_amount)
        rescue
            puts "Can't bet that"
            retry
        end

        betting_amount = betting_amount.to_i
        @pot -= betting_amount
        betting_amount
    end
end