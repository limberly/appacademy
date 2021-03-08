class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }



  attr_reader :pegs

  def initialize(pegs)
    raise "not a valid peg" if Code.valid_pegs?(pegs) == false

    @pegs = pegs.map {|p| p.upcase}
  end

  def self.valid_pegs?(arr)
    arr.all? {|c| POSSIBLE_PEGS.keys.include?(c.upcase)}
  end
  
  def self.random(num)
    peg = POSSIBLE_PEGS.keys
    randoms = (0...num).map {|n| peg[rand(4)]}
    Code.new(randoms)
  end

  def self.from_string(str)
    Code.new(str.split(""))
  end

  def [](id)
    @pegs[id]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count = 0
    guess.pegs.each_with_index {|p, id| count += 1 if @pegs[id] == p}
    count
  end

  def num_near_matches(guess)
    count = 0
    guess.pegs.each_with_index do |p, id|
      if @pegs[id] != p && @pegs.include?(p)
        count += 1
      end
    end
    count
  end

  def ==(guess)
    @pegs == guess.pegs
  end
end
