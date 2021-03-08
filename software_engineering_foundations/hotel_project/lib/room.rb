class Room
    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end

    def capacity
        @capacity
    end

    def occupants
        @occupants
    end

    def full?
        return true if @occupants.length >= @capacity
        return false
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(name)
        if full?
            return false
        else
            @occupants << name
            return true
        end
    end
end
