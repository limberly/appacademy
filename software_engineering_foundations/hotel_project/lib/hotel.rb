require_relative "room"
require 'byebug'

class Hotel
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        if @rooms[room_name]
            return true
        else
            return false
        end
    end

    def check_in(person, room_name)
        if room_exists?(room_name)
            if @rooms[room_name].add_occupant(person)
               puts "check in successful"
            else
                puts "sorry, room is full"
            end
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        if @rooms.any? {|key, value| value.available_space != 0}
            return true
        end
        return false
    end

    def list_rooms
        @rooms.each do |key, value|
            puts "#{key}: #{value.available_space}"
        end
    end
end
