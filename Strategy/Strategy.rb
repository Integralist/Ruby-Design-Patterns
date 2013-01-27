#!/usr/bin/env ruby

class Report
    attr_reader :title, :text
    attr_accessor :formatter

    def initialize formatter
        @title = 'Monthly Report'
        @text = ['Things are going', 'really, really well.']
        @formatter = formatter
    end

    def output_report
        @formatter.output_report self
    end
end

class HTMLFormatter
    def output_report context
        puts('<html>')
        puts('<head>')
        puts("<title>#{context.title}</title>")
        puts('</head>')
        puts('<body>')
        context.text.each { |line| puts("<p>#{line}</p>") }
        puts('</body>')
        puts('</html>')
    end
end

class PlainTextFormatter
    def output_report context
        puts "***** #{context.title} *****"
        context.text.each { |line| puts line }
    end
end

report = Report.new HTMLFormatter.new
report.output_report

# We can now swap out the implementation half way through the program
report.formatter = PlainTextFormatter.new
report.output_report