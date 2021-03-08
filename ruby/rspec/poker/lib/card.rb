require_relative 'deck'

class Card
    attr_accessor :cards
    def initialize(cards=[])
        @cards = cards
    end

    def get_card_from_deck(deck)
        missing_number_of_cards = 5 - @cards.length
        @cards += deck.deal_cards(missing_number_of_cards)
    end
end