#!/usr/bin/env ruby

module Subject
    def initialize
        @observers = []
    end

    def add_observer observer
        @observers << observer
    end

    def delete_observer observer
        @observers.delete observer
    end

    def notify_observers
        @observers.each do |observer|
            observer.update self
        end
    end
end

class Employee
    include Subject

    attr_reader :name, :address, :salary

    def initialize name, title, salary
        super() # this is one instance where we must use parenthesis to execute a method**
        @name = name
        @title = title
        @salary = salary
    end

    # we have to define our own custom setter 
    # as this setter needs to trigger a notification as well
    def salary= new_salary
        old_salary = @salary
        @salary = new_salary

        # prevent notifying observers unnecessarily
        if old_salary != new_salary
            notify_observers
        end
    end
end

=begin
    **Calling super the way we do here, with the parentheses, calls the method in the superclass with no arguments. 
    If you omit the parentheses, you will be calling super with the original set of arguments to the current method 
    in this case, name, title, salary, and payroll_manager.
=end

class Payroll
    def update changed_employee
        puts "Cut a new check for #{changed_employee.name}!"
        puts "His salary is now #{changed_employee.salary}!"
    end
end

class TaxMan
    def update changed_employee
        puts "Send #{changed_employee.name} a new tax bill!"
    end
end

fred = Employee.new 'Fred', 'Crane Operator', 30000
payroll = Payroll.new
tax_man = TaxMan.new

fred.add_observer payroll
fred.add_observer tax_man

fred.salary = 35000