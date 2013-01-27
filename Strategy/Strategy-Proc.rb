#!/usr/bin/env ruby

class Report
    attr_reader :title, :text
    attr_accessor :formatter

    # Notice we're passing through a code block instead of a Class instance now
    def initialize formatter
        @title = 'Monthly Report'
        @text = ['Things are going', 'really, really well.']
        @formatter = formatter
    end

    def output_report
        # Because we stored a code block instead of a Class instance, 
        # for us to utilise the Proc we need to use the `call` method
        @formatter.call self
    end
end

# We now create a set of Proc's instead of Classes

HTML_FORMATTER = lambda do |context|
    puts('<html>')
    puts('<head>')
    puts("<title>#{context.title}</title>")
    puts('</head>')
    puts('<body>')
    context.text.each { |line| puts("<p>#{line}</p>") }
    puts('</body>')
    puts('</html>')
end

PLAINTEXT_FORMATTER = lambda do |context|
    puts("***** #{context.title} *****")
    context.text.each { |line| puts(line) }
end

# We now create a new report differently by passing through the Proc instead of a new Class instance

report = Report.new HTML_FORMATTER
report.output_report

# We can now swap out the implementation half way through the program
report.formatter = PLAINTEXT_FORMATTER
report.output_report

=begin
We can use a simple inline code block as well if we wanted, 
but we'd need to change the Report Class to accept a code block like so...

    def initialize &formatter

...and then call it like so...

    report = Report.new { |context|
        puts("***** INLINE! #{context.title} *****")
        context.text.each { |line| puts(line) }
    }
    report.output_report

...note that the Ruby convention is to use Do...End for multi-line functions/methods, 
but for code blocks I prefer the use of curly braces {} as I feel the intent of the code is clearer
=end
