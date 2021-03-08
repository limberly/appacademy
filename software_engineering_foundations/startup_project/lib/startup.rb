require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.include?(title)
    end

    def >(startup)
        if self.funding > startup.funding
            true
        else
            false
        end
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            raise "not a valid title"
        end

        @employees << Employee.new(employee_name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = salaries[employee.title]
        if funding > salary
            employee.pay(salary)
            @funding -= salary
        else
            raise "don't have enough money to pay"
        end
    end

    def payday
        employees.each {|e| pay_employee(e)}
    end

    def average_salary
        sals = employees.map {|e| salaries[e.title]}
        sals.sum(0.0) / size
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        self.salaries.merge!(startup.salaries) {|key, oldval| oldval}
        @employees.concat(startup.employees)
        startup.close
    end
end
