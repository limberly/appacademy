class Employee
    attr_reader :name, :title, :salary, :boss
    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end

class Manager < Employee
    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        sals = @employees.inject(0) {|s, e| s += e.salary}
        sals * multiplier
    end
end

ned = Employee.new("ned", "Founder", 1000000, nil)
shawna = Employee.new("Shawna", "TA", 12000, "darren")
david = Employee.new("David", "TA", 10000, "darren")
darren = Manager.new("Darren", "TA Manager", 78000, "ned", [shawna, david])

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000