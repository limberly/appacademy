require_relative 'card'

class Hand

    WORD_2_NUM = {
        "A" => 1,
        "J" => 11,
        "Q" => 12,
        "K" => 13
    }

    ALPHA = ("A".."Z").to_a

    def check_hand(card)
        return straight_flush(card) || four_of_kind(card) || full_house(card) || three_of_kind(card) || two_pair(card) || pair(card) || 'no pair'
    end

    # https://en.wikipedia.org/wiki/List_of_poker_hands#High_card
    # https://en.wikipedia.org/wiki/Poker_probability

    def straight_flush(card)
        card_with_number = get_card_with_number(card).to_h
        same_suit = card_with_number.values.uniq.length == 1
        sorted_numbers = card_with_number.keys.sort { |a, b| a <=> b }
        sequential_numbers = true
        sorted_numbers.each_with_index do |n, id|
            if !sorted_numbers[id + 1].nil?
                sequential_numbers = false if n != (sorted_numbers[id + 1] - 1)
            end
        end
        royal_card_numbers = [10, 11, 12, 13, 1]
        has_royal_members = royal_card_numbers.all? {|n| card_with_number.has_key?(n)}
        
        return 'royal flush' if same_suit && has_royal_members
        return 'straight flush' if same_suit && sequential_numbers && (sorted_numbers.length == 5)
        return 'flush' if same_suit && !sequential_numbers && (sorted_numbers.length == 5)
        return 'straight' if !same_suit && sequential_numbers && (sorted_numbers.length == 5)
        false
    end

    def four_of_kind(card)
        uniq_numbers = how_many_same_number_cards(card)
        return 'four of a kind' if uniq_numbers.values.max == 4
        return false
    end

    def full_house(card)
        uniq_numbers = how_many_same_number_cards(card)
        # debugger
        three_n_two = uniq_numbers.values.sort { |a, b| a <=> b } == [2, 3]
        return 'full house' if three_n_two
        return false
    end

    def three_of_kind(card)
        uniq_numbers = how_many_same_number_cards(card)
        return 'three of a kind' if uniq_numbers.values.max == 3
        return false
    end

    def two_pair(card)
        uniq_numbers = how_many_same_number_cards(card)
        counts = uniq_numbers.values
        return 'two pair' if counts.max == 2 && (counts.count(2) == 2)
        return false
    end

    def pair(card)
        uniq_numbers = how_many_same_number_cards(card)
        counts = uniq_numbers.values
        return 'pair' if counts.max == 2 && (counts.count(2) == 1)
        return false
    end

    def how_many_same_number_cards(card)
        card_with_number = get_card_with_number(card)
        uniq_numbers = card_with_number.to_h.transform_values {|v| 0}
        card_with_number.each do |c|
            uniq_numbers[c[0]] += 1
        end
        uniq_numbers
    end

    def seperate_num_suit(card)
        cards = card.cards
        separated = cards.map do |c| 
            one_card = c.split("")
            if one_card.length == 3
                one_card = [one_card[0]+one_card[1], one_card[2]]
            else
                one_card
            end
        end
        separated
    end

    def change_word_to_number(separated)
        separated.map do |c|
            num = c[0]
            suit = c[1]
            if WORD_2_NUM.has_key?(num)
                [WORD_2_NUM[num], suit]
            else
                [num.to_i, suit]
            end
        end
    end

    def get_card_with_number(card)
        separated = seperate_num_suit(card)
        card_with_number = change_word_to_number(separated)
    end
end