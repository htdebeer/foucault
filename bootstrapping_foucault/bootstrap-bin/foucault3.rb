require 'ostruct'
require 'optparse'

# Set all default options
options = OpenStruct.new
options.output = ''
options.debug = false

OptionParser.new do |opts|
    
    opts.banner = "Literate programming with Foucault — taking a narrative turn"
    opts.separator ""
    opts.separator "Usage: foucault [options] input files"
    opts.separator ""
    opts.separator "Options:"

    opts.on("-o", 
            "--output [PATH]", 
            "Path to output collected program text to") do |path|
        options.output = path
    end

    opts.on("-d", "--debug", "Generate program texts in debug mode") do |d|
        options.debug = true
    end

    opts.on_tail("-h",
                 "--help",
                 "Show this message") do
        puts opts
    end

end.parse!

document = []
ARGV.each do |input_file|
    document.concat File.readlines input_file
end
def program_collector(document, debug = false)
    program = []

    require_relative 'lib/code_block_determinator.rb'

    line_determinator = CodeBlockDeterminator.new

    while not document.empty? do

        line = document.shift

        if line_determinator.collect_line? line
            program.push line
        elsif debug
            program.push "\n"
        else
            # ignore this line
        end

    end

    program.join
end

program = program_collector document, options.debug

if not options.output.empty? then
    # try to write collected program text to file specified in options.output
    File.open(options.output, "w") do |file|
        file.puts program
    end
else
    puts program
end
