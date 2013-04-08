class SimpleWriter
    def initialize path
        @file = File.open(path, 'w')
    end

    def write_line line
        @file.print line
        @file.print "\n"
    end

    def pos
        @file.pos
    end

    def rewind
        @file.rewind
    end

    def close
        @file.close
    end
end

# Decorator object

class WriterDecorator
    def initialize real_writer
        @real_writer = real_writer
    end

    def write_line line
        @real_writer.write_line line
    end

    def pos
        @real_writer.pos
    end

    def rewind
        @real_writer.rewind
    end

    def close
        @real_writer.close
    end
end

# Different Implementations

class NumberingWriter < WriterDecorator
    def initialize real_writer
        super real_writer
        @line_number = 1
    end

    def write_line line
        @real_writer.write_line "#{@line_number}: #{line}"
        @line_number += 1
    end
end

class CheckSummingWriter < WriterDecorator
    attr_reader :check_sum # this class has an enhanced interface compared to the other 'writer' objects, as we now also provide a `check_sum` method

    def initialize real_writer
        @real_writer = real_writer
        @check_sum = 0
    end

    def write_line line
        line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
        @check_sum += "\n"[0] % 256
        @real_writer.write_line line
    end
end

class TimeStampingWriter < WriterDecorator
    def write_line(line)
        @real_writer.write_line "#{Time.new}: #{line}"
    end
end

# Implementation

writer_a = NumberingWriter.new(SimpleWriter.new('delegation_a.txt'))
writer_a.write_line('Hello out there')

writer_b = CheckSummingWriter.new(SimpleWriter.new('delegation_b.txt'))
writer_b.write_line('Hello out there')

# We can implement all sorts of crazy decorated versions
writer_c = CheckSummingWriter.new(TimeStampingWriter.new(NumberingWriter.new(SimpleWriter.new('delegation_c.txt'))))
writer_c.write_line('Hello out there')