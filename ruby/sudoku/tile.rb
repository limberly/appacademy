require 'colorize'

class Tile
    attr_reader :value
    def initialize(value=0, given=false)
        @value = value
        @given = given
    end

    def to_s
        if @given == true
            print @value.to_s.blue.on_green
        elsif
            @value != 0
            print @value.to_s.magenta.on_green
        else
            print @value.to_s.yellow.on_green
        end
    end

    def value=(val)
        @value=val unless @given == true
    end
end