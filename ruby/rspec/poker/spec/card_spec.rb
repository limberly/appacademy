require 'card'
require 'deck'
require 'game'
require 'hand'
require 'player'
require 'rspec'
require 'byebug'

describe Card do
    let(:card) {Card.new}
    let(:deck) {Deck.new}

    context '#initialize' do
        it 'has an array of cards' do
            expect(card.cards).to be_a_kind_of(Array)
        end
    end

    context '#get_card_from_deck' do
        it 'when empty, receives cards from deck to have 5 cards' do
            card.get_card_from_deck(deck)
            expect(card.cards.length).to eq(5)
        end

        it 'when not have 5 cards, receives cards from deck to have 5 cards' do
            card.cards += ["AH", "2H"]
            card.get_card_from_deck(deck)
            expect(card.cards.length).to eq(5)
        end
    end
end

describe Deck do
    let(:deck) {Deck.new}
    let(:card) {Card.new}
    context '#initialize' do
        it 'initializes with 52 cards' do
            expect(deck.cards.length).to eq(52)
        end
    end

    context '#deal_cards' do
        it 'deals so the player has 5 cards' do
            missing_number_of_cards = 5 - card.cards.length
            expect(deck.deal_cards(missing_number_of_cards).length).to eq(missing_number_of_cards)
        end

        it 'removes dealt cards from the deck' do
            deck.deal_cards(5)
            number_of_remaining_cards = 52 - 5
            expect(deck.cards.length).to eq(number_of_remaining_cards)
        end
    end
end

# describe Hand do
#     let(:deck) {Deck.new}
#     let(:card) {Card.new}
#     let(:hand) {Hand.new}

#     context '#straight_flush' do
#         it 'recognizes royal flush' do
#             card.cards = ["10S", "JS", "QS", "KS", "AS"]
#             expect(hand.straight_flush(card)).to eq('royal flush')
#         end

#         it 'recognizes straight_flush' do
#             card.cards = ["AS", "2S", "3S", "4S", "5S"]
#             expect(hand.straight_flush(card)).to eq('straight flush')
#         end

#         it 'recognizes flush' do
#             card.cards = ["AS", "6S", "3S", "8S", "QS"]
#             expect(hand.straight_flush(card)).to eq('flush')
#         end

#         it 'recognizes straight' do
#             card.cards = ["AS", "2C", "3D", "4H", "5S"]
#             expect(hand.straight_flush(card)).to eq('straight')
#         end

#         it 'returns false if four of a kind' do
#             card.cards = card.cards = ["5S", "5C", "5D", "4H", "5S"]
#             expect(hand.straight_flush(card)).to eq(false)
#         end

#         it 'returns false if full house' do
#             card.cards = ["6S", "6C", "6D", "KH", "KS"]
#             expect(hand.straight_flush(card)).to eq(false)
#         end

#         it 'returns false if three of a kind' do
#             card.cards = ["QC", "QS", "QH", "9H", "2S"]
#             expect(hand.straight_flush(card)).to eq(false)
#         end

#         it 'returns false if two pair' do
#             card.cards = ["JH", "JS", "3C", "3S", "2H"]
#             expect(hand.straight_flush(card)).to eq(false)
#         end

#         it 'returns false if pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.straight_flush(card)).to eq(false)
#         end
#     end

#     context '#four_of_kind' do
#         it 'recognizes four of a kind' do
#             card.cards = ["5S", "5C", "5D", "4H", "5S"]
#             expect(hand.four_of_kind(card)).to eq('four of a kind')
#         end

#         it 'returns false if full house' do
#             card.cards = ["6S", "6C", "6D", "KH", "KS"]
#             expect(hand.four_of_kind(card)).to eq(false)
#         end

#         it 'returns false if three of a kind' do
#             card.cards = ["QC", "QS", "QH", "9H", "2S"]
#             expect(hand.four_of_kind(card)).to eq(false)
#         end

#         it 'returns false if two pair' do
#             card.cards = ["JH", "JS", "3C", "3S", "2H"]
#             expect(hand.four_of_kind(card)).to eq(false)
#         end

#         it 'returns false if pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.four_of_kind(card)).to eq(false)
#         end
#     end

#     context '#full_house' do
#         it 'recognizes full house' do
#             card.cards = ["6S", "6C", "6D", "KH", "KS"]
#             expect(hand.full_house(card)).to eq('full house')
#         end

#         it 'returns false if three of a kind' do
#             card.cards = ["QC", "QS", "QH", "9H", "2S"]
#             expect(hand.full_house(card)).to eq(false)
#         end

#         it 'returns false if two pair' do
#             card.cards = ["JH", "JS", "3C", "3S", "2H"]
#             expect(hand.full_house(card)).to eq(false)
#         end

#         it 'returns false if pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.full_house(card)).to eq(false)
#         end
#     end

#     context '#three_of_kind' do
#         it 'recognizes three of a kind' do
#             card.cards = ["QC", "QS", "QH", "9H", "2S"]
#             expect(hand.three_of_kind(card)).to eq('three of a kind')
#         end

#         it 'returns false if two pair' do
#             card.cards = ["JH", "JS", "3C", "3S", "2H"]
#             expect(hand.three_of_kind(card)).to eq(false)
#         end

#         it 'returns false if pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.three_of_kind(card)).to eq(false)
#         end
#     end

#     context '#two_pair' do
#         it 'recognizes two pair' do
#             card.cards = ["JH", "JS", "3C", "3S", "2H"]
#             expect(hand.two_pair(card)).to eq('two pair')
#         end

#         it 'returns false if pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.two_pair(card)).to eq(false)
#         end
#     end

#     context '#pair' do
#         it 'recognizes pair' do
#             card.cards = ["10S", "10H", "8S", "7H", "4C"]
#             expect(hand.pair(card)).to eq('pair')
#         end
#     end
# end

describe Hand do
    let(:deck) {Deck.new}
    let(:card) {Card.new}
    let(:hand) {Hand.new}

    context '#check_hand' do
        it 'recognizes royal flush' do
            card.cards = ["10S", "JS", "QS", "KS", "AS"]
            expect(hand.check_hand(card)).to eq('royal flush')
        end

        it 'recognizes straight_flush' do
            card.cards = ["AS", "2S", "3S", "4S", "5S"]
            expect(hand.check_hand(card)).to eq('straight flush')
        end

        it 'recognizes flush' do
            card.cards = ["AS", "6S", "3S", "8S", "QS"]
            expect(hand.check_hand(card)).to eq('flush')
        end

        it 'recognizes straight' do
            card.cards = ["AS", "2C", "3D", "4H", "5S"]
            expect(hand.check_hand(card)).to eq('straight')
        end

        it 'recognizes four of a kind' do
            card.cards = ["5S", "5C", "5D", "4H", "5S"]
            expect(hand.check_hand(card)).to eq('four of a kind')
        end

        it 'recognizes full house' do
            card.cards = ["6S", "6C", "6D", "KH", "KS"]
            expect(hand.check_hand(card)).to eq('full house')
        end


        it 'recognizes three of a kind' do
            card.cards = ["QC", "QS", "QH", "9H", "2S"]
            expect(hand.check_hand(card)).to eq('three of a kind')
        end

        it 'recognizes two pair' do
            card.cards = ["JH", "JS", "3C", "3S", "2H"]
            expect(hand.check_hand(card)).to eq('two pair')
        end

        it 'recognizes pair' do
            card.cards = ["10S", "10H", "8S", "7H", "4C"]
            expect(hand.check_hand(card)).to eq('pair')
        end

        it 'recognizes no pair' do
            card.cards = ["KD", "QD", "7S", "4S", "3H"]
            expect(hand.check_hand(card)).to eq('no pair')
        end
    end
end