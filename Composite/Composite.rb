#!/usr/bin/env ruby

# Component Class (similar to an Abstract/Interface Base Class)
class Task
    attr_reader :name

    def initialize name
        @name = name
    end

    def get_time_required
        0.0
    end
end

# Leaf Class
class AddDryIngredientsTask < Task
    def initialize
        puts 'AddDryIngredientsTask Running'
        super 'Add dry ingredients'
    end

    def get_time_required
        1.0 # 1 minute to add flour and sugar
    end
end

# Leaf Class
class AddLiquidsTask < Task
    def initialize
        puts 'AddLiquidsTask Running'
        super 'Keep it moist!'
    end

    def get_time_required
        1.0 # Pour for 1 minute
    end
end

# Leaf Class
class MixTask < Task
    def initialize
        puts 'MixTask Running'
        super 'Mix that batter up!'
    end

    def get_time_required
        3.0 # Mix for 3 minutes
    end
end

# Leaf Class
class FillPanTask < Task
    def initialize
        puts 'FillPanTask Running'
        super 'Fill up the pan'
    end

    def get_time_required
        1.0 # Mix for 1 minute
    end
end

# Leaf Class
class BakeTask < Task
    def initialize
        puts 'BakeTask Running'
        super 'Start baking'
    end

    def get_time_required
        1.0 # Mix for 1 minute
    end
end

# Leaf Class
class FrostTask < Task
    def initialize
        puts 'FrostTask Running'
        super 'Add some frosting'
    end

    def get_time_required
        1.0 # Mix for 1 minute
    end
end

# Leaf Class
class LickSpoonTask < Task
    def initialize
        puts 'LickSpoonTask Running'
        super 'Time to lick the spoon'
    end

    def get_time_required
        1.0 # Mix for 1 minute
    end
end

# Let's create a Class that all our composite classes will inherit from
# This class will also act like an abstract class of sorts
class CompositeTask < Task
    def initialize name
        super name
        @sub_tasks = []
    end

    def add_sub_task task
        @sub_tasks << task
    end

    def remove_sub_task task
        @sub_tasks.delete task
    end

    def get_time_required
        time = 0.0
        @sub_tasks.each { |task| time += task.get_time_required }
        time
    end
end

# So here we have a composite class (as it contains multiple sub tasks)
class MakeBatterTask < CompositeTask
    def initialize
        puts 'MakeBatterTask Running'
        super 'Make batter'
        add_sub_task AddDryIngredientsTask.new
        add_sub_task AddLiquidsTask.new
        add_sub_task MixTask.new
    end
end

# Here again we have another composite class as it contains multiple sub tasks (it also contains a composite task!)
class MakeCakeTask < CompositeTask
    def initialize
        puts 'MakeCakeTask Running'
        super 'Make cake'
        add_sub_task MakeBatterTask.new # this is a composite class itself
        add_sub_task FillPanTask.new
        add_sub_task BakeTask.new
        add_sub_task FrostTask.new
        add_sub_task LickSpoonTask.new
    end
end

# Fire up our application by making a new cake
cake = MakeCakeTask.new
puts cake.get_time_required # 9.0

=begin
It would be nice, for example, to be able to add tasks to a CompositeTask with the << operator, just as we could in an array:

composite = CompositeTask.new('example')
composite << MixTask.new

It turns out that we can get this done by simply renaming the add_sub_task method:

def <<(task)
  @sub_tasks << task
end

We might also want to get at our subtasks by the familiar array indexing syntax, something like this:

puts(composite[0].get_time_required)
composite[1] = AddDryIngredientsTask.new

This is once again a simple matter of picking the right name for our method. 
Ruby will translate object[i] into a call to a method with the odd name of [], 
which takes one parameter, the index. To add support for this operation to our CompositeTask class, we simply add a method:

def [](index)
  @sub_tasks[index]
end

In the same way, object[i] = value is translated into a call to the method with the even stranger name of []=, 
which takes two parameters, the index and the new value:

def []=(index, new_value)
  @sub_tasks[index] = new_value
end
=end