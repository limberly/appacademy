require 'byebug'

fishy = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish(fishy)
    longest = ""
    fishy.each do |f1|
        fishy.each do |f2|
            longest = f2 if longest.length < f2.length
        end
    end
    longest
end

def merge_sort (array, &prc)
    return array if array.length <= 1

    mid_idx = array.length / 2
    merge(
      merge_sort(array.take(mid_idx), &prc),
      merge_sort(array.drop(mid_idx), &prc),
      &prc
    )
  end

def merge(left, right, &prc)
    merged_array = []
    prc = Proc.new { |num1, num2| num1 <=> num2 } unless block_given?
    until left.empty? || right.empty?
      case prc.call(left.first.length, right.first.length)
      when -1
        merged_array << left.shift
      when 0
        merged_array << left.shift
      when 1
        merged_array << right.shift
      end
    end

    merged_array + left + right
end

def clever(fishy)
    
    fishy.inject do |long, fish|
        long.length < fish.length ? fish : long
    end
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
tiles_hash = Hash.new
tiles_array.each_with_index {|t, id| tiles_hash[t] = id}

def slow_dance(move, tiles)
    tiles.each_with_index {|t, id| return id if move == t}
end


def fast_dance(move, tiles)
    return tiles[move]
end

puts fast_dance("up", tiles_hash)
puts fast_dance("right-down", tiles_hash)