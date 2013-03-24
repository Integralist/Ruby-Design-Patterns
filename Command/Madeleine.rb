require 'madeleine'

class Employee
    attr_accessor :name, :number, :address

    def initialize name, number, address
        @name = name
        @number = number
        @address = address
    end

    def to_s
        "Employee: name: #{name}, number: #{number}, address: #{address}"
    end
end

class EmployeeManager
    def initialize
        @employees = {}
    end

    def add_employee e
        @employees[e.number] = e
    end

    def change_address number, address
        employee = @employees[number]
        raise "No such employee" if not employee
        employee.address = address
    end

    def delete_employee number
        @employees.remove number
    end

    def find_employee number
        @employees[number]
    end
end

class AddEmployee
    def initialize employee
        @employee = employee
    end

    def execute system
        system.add_employee @employee
    end
end

class DeleteEmployee
    def initialize number
        @number = number
    end

    def execute system
        system.add_employee @number
    end
end

class ChangeAddress
    def initialize number, address
        @number = number
        @address = address
    end

    def execute system
        system.change_address @number, @address
    end
end

class FindEmployee
    def initialize number
        @number = number
    end

    def execute system
        system.find_employee @number
    end
end

# Create a new Madeleine object store by passing in the name of a directory where it will persist its data
store = SnapshotMadeleine.new('employees') { EmployeeManager.new }

# We also need a thread that will save the state of the object store to disk every so often. 
# Our thread simply tells Madeleine to save the current state of the system to disk every 20 seconds.
Thread.new do
    while true
        sleep 20
        madeleine.take_snapshot
    end
end

# With this thread running, we can start throwing commands at our personnel system:
tom = Employee.new 'tom', '1001', '1 Division Street'
harry = Employee.new 'harry', '1002', '3435 Sunnyside Ave'

store.execute_command AddEmployee.new tom
store.execute_command AddEmployee.new harry

# With Tom and Harry safely in the Madeleine store, we can run some queries:
puts store.execute_command FindEmployee.new '1001'
puts store.execute_command FindEmployee.new '1002'

store.execute_command ChangeAddress.new('1001', '555 Main Street')

puts store.execute_command FindEmployee.new '1001'

=begin
    Madeleine is a great example of the Command pattern in action. 

    As the commands arrive at Madeleine—add this employee or change this one address 
    Madeleine uses this pattern to modify its in-memory copy of the data. 

    But Madeleine also writes the command out to a file. 
    Should your system crash, Madeleine can restore its state back to the correct state by 
    reading the last snapshot and applying all of the outstanding commands. 

    Every so often—every 20 seconds in our example—we write the current data out to a new snapshot 
    and clear out all of the commands that have accumulated on disk.
=end