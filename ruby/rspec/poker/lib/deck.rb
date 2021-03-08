class Deck
    attr_accessor :cards
    def initialize
        @cards = []
        populate_cards
    end

    def populate_cards
        numbers = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
        factions = ['H', 'S', 'C', 'D']
        factions.each do |fac|
            numbers.each do |num|
                @cards << num + fac
            end
        end
    end

    def deal_cards(missing_cards)
        cards_to_give = @cards.sample(missing_cards)
        @cards.reject! {|ele| cards_to_give.include?(ele)}
        cards_to_give
    end
end