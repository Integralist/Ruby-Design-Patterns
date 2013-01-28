#!/usr/bin/env ruby

require 'observer'

class Employee
    include Observable

    attr_reader :name, :address, :salary

    def initialize name, title, salary
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
            changed
            notify_observers self # **
        end
    end
end

=begin
    **To cut down on redundant notifications to the observers, 
    the standard Observable module requires that you call the changed method before you call notify_observers. 
    The changed method sets a Boolean flag that says the object really has changed; 
    the notify_observers method will not actually make any notifications if the changed flag is not set to true. 
    Each call to notify_observers sets the changed flag back to false.
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