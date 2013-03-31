class Command
    attr_reader :description

    def initialize description
        @description = description
    end

    def execute 
        # Interface
    end
end

class CreateFile < Command
    def initialize path, contents
        super "Create file: #{path}"
        @path = path
        @contents = contents
    end

    def execute
        f = File.open @path, 'w'
        f.write @contents
        f.close
    end

    def unexecute
        File.delete @path
    end
end

=begin
    To undo a deleted file we need to first store its content 
    so when the user reverses the decision to delete we can 
    recreate the file with that same content.

    Note: there should really be a similar process for creating 
    a new file because the file requested to be created might 
    already exist and so we'd overwrite the original file.
=end
class DeleteFile < Command
    def initialize path
        super "Delete file: #{path}"
        @path = path
    end

    def execute
        if File.exists? @path
            @contents = File.read @path
        end
        f = File.delete @path
    end

    def unexecute
        if @contents
            f = File.open @path, 'w'
            f.write @contents
            f.close
        end
    end
end

class CopyFile < Command
    def initialize source, target
        super "Copy file: #{source} to #{target}"
        @source = source
        @target = target
    end

    def execute
        if File.exists? @target
            @contents = File.read @target
        else
            @previous_version = false
        end

        FileUtils.copy @source, @target
    end

    def unexecute
        if @previous_version
            f = File.open @target, 'w'
            f.write @contents
            f.close
        else
            File.delete @target
        end
    end
end

# Notice this is the Composite design pattern!
# We have a class that acts like a command that holds sub commands (sub commands being leafs)!
class CompositeCommand < Command
    def initialize
        @commands = []
    end

    def add_command cmd
        @commands << cmd
    end

    def execute
        @commands.each { |cmd| cmd.execute }
    end

    def unexecute
        @commands.each.reverse { |cmd| cmd.unexecute }
    end

    # At any point we can call this method to find out what would be run if we called `execute` on this class
    def description
        description = ''
        @commands.each { |cmd| description += cmd.description + '\n' }
        description
    end
end

cmds = CompositeCommand.new

cmds.add_command(CreateFile.new 'file1.txt', 'hello world\n')
cmds.add_command(CopyFile.new 'file1.txt', 'file2.txt')
cmds.add_command(DeleteFile.new 'file1.txt')

cmds.execute
puts cmds.description