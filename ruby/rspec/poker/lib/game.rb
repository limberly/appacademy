require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'

class Game
    def initialize(player1 = Player.new("player1"), player2 = Player.new("player2"))
        @players = [player1, player2]
        @deck = Deck.new
        @pot = 0
        @next_turn = player1
    end

    def deal_cards
        @players.each {|p| p.hand.get_card_from_deck(@deck)}
    end

    def ask_user_choice
        @players.each_with_index do |p, id|
            puts "#{p.name}'s turn"
            p.show_hands
            choice = p.user_input
            if choice == 'raise'
                @pot += p.bet
            elsif choice == 'see'
                puts @pot
            elsif choice == 'fold'
                @players.delete_at(id)
            elsif choice == 'discard'
                p.discard
            end
        end
    end

    def player_hands
        hands = Hash.new
        to_check_hands = Hand.new
        @players.each do |p|
            hands[p] = to_check_hands.check_hand(p.hand)
        end
        hands
    end

    def play
        possible_hands = {
            "royal flush" => 0,
            "straight flush" => 1,
            "four of a kind" => 2,
            "full house" => 3,
            "flush" => 4,
            "straight" => 5,
            "three of a kind" => 6,
            "two pair" => 7,
            "pair" => 8,
            "no pair" => 9
        }

        # first round
        deal_cards
        ask_user_choice
        if @players.length == 1
            puts "#{@players[0].name} won"
            return
        end
        deal_cards
        ask_user_choice
        if @players.length == 1
            puts "#{@players[0].name} won"
            return
        end

        get_hands = player_hands

        @players.each do |p|
            get_hands[p] = possible_hands[get_hands[p]]
        end
        sorted = get_hands.sort_by {|k, v| v}
        
        puts "#{sorted[0][0].name} is the winner"

    end

end

g = Game.new
g.play