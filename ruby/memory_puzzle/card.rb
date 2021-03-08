class Card
    def initialize
        @value = nil
        @show = false
    end
    
    def value= (card_value)
        @value ||= card_value
    end

    def hide
        @show = false
    end

    def reveal
        @show = true
    end

    def value
        if @show == true
            @value
        else
            ""
        end
    end
end