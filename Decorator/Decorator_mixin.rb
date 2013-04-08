module TimeStampingWriter
    def write_line line
        super "#{Time.new}: #{line}"
    end
end

module NumberingWriter
    attr_reader :line_number

    def write_line line
        @line_number = 1 unless @line_number
        super "#{@line_number}: #{line}"
        @line_number += 1
    end
end

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

class Writer
    def write line
        @f.write line
    end
end

w = SimpleWriter.new('mixin.txt')
w.extend(NumberingWriter)
w.extend(TimeStampingWriter)
w.write_line('hello')