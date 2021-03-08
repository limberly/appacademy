require_relative "code"

class Mastermind
    def initialize(num)
        @secret_code = Code.random(num)
    end

    def print_matches(guess)
        p @secret_code.num_exact_matches(guess)
        p @secret_code.num_near_matches(guess)
    end

    def ask_user_for_guess
        p "Enter a code"
        guess = Code.from_string(gets.chomp)
        print_matches(guess)
        @secret_code == guess
    end
end
