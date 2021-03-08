require 'byebug'
require 'set'
class WordChainer
    attr_reader :all_seen_words
    def initialize(dictionary_file_name)
        dict = File.open(dictionary_file_name)
        @dictionary = dict.readlines.map(&:chomp).to_set
        dict.close

        @current_words = []
        @all_seen_words = Hash.new 
        @alpha = ("a".."z").to_a
    end

    def adjacent_words(word)
        alpha = ("a".."z").to_a
        word = word.downcase
        adjacents = []
        word.each_char.with_index do |c, id|
            alpha.each do |a|
                unless a == c
                    changed = word.clone
                    changed[id] = a
                    adjacents << changed if @dictionary.include?(changed)
                end
            end
        end
        return "could not find adjacent words" if adjacents.empty?
        adjacents
    end

    def run(source, target)
        @current_words << source
        @all_seen_words[source] = nil

        while !@current_words.empty?
            explore_current_words
            path = build_path(target)
            return puts "Found path: #{path}" if path != 1
        end

        puts "Could not find path"
        
        
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |word|
            adjacent_words(word).each do |adj|
                next if @all_seen_words.has_key?(adj)
                new_current_words << adj
                @all_seen_words[adj] = word
            end
        end
        new_current_words.each do |word|
            puts "Adj: #{word} Source: #{@all_seen_words[word]} "
        end
        @current_words = new_current_words
    end

    def build_path(target)
        prior = [target]
        source = @all_seen_words.select {|k, v| v == nil}.keys[0]
            if @all_seen_words.include?(target)
                new_target = target
                while prior[-1] != nil
                    new_target = @all_seen_words[new_target]
                    prior << new_target
                end
                prior.pop
                return prior.reverse.join("\n")
            end
            
        return 1
    end

end

dict = WordChainer.new("dictionary.txt");
puts dict.run("duck", "ruby")