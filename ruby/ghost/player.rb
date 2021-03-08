class Player
    attr_reader :name
    ALPHABET = "abcdefghijklmnopqrstuvwxyz"
    def initialize(name)
        @name = name
    end

    def guess
        while true
            puts "-----------------"
            print "Choose a letter: "
            guessed = gets.chomp
            if (guessed.length == 1) && (guessed.is_a? String) && (ALPHABET.include?(guessed))
                return guessed.downcase
            else
                puts "Invalid move. Enter a single character"
            end
        end
    end
end