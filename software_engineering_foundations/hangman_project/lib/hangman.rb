require 'byebug'

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      true
    else
      false
    end
  end
  
  def get_matching_indices(char)
    idx = []
    @secret_word.each_char.with_index {|c, id| idx << id if c == char}
    idx
  end

  def fill_indices(char, arr)
    arr.each {|id| @guess_word[id] = char}
  end

  def try_guess(char)
    attempt = already_attempted?(char)
    matching_array = get_matching_indices(char)
    if attempt
      puts "that has already been attempted"
      false
    elsif !attempt
      @attempted_chars << char
      fill_indices(char, matching_array)
      @remaining_incorrect_guesses -= 1 if matching_array.length == 0
      true
    end
  end

  def ask_user_for_guess
    p "Enter a char: "
    try_guess(gets.chomp)
  end

  def win?
    guessed = @guess_word.join("")
    if guessed == @secret_word
      puts "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts 'LOSE'
      true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      true
    else
      false
    end
  end
end
