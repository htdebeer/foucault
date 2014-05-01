#!/usr/bin/env ruby
# Copyright 2014 Huub de Beer 
#
# This file is part of Foobar.
#
# Foucault is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.  
#          
# Foucault is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# Foucault.  If not, see <http://www.gnu.org/licenses/>.
require 'ostruct'
require 'optparse'

# Set all default options
options = OpenStruct.new
options.mirror = false
options.output_dir = ''
options.output = ''
options.debug = false

OptionParser.new do |opts|
    
    opts.banner = "Literate programming with Foucault -- taking a narrative turn"
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

    require 'foucault/code_block_determinator'

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
    # No output file specified: use STDOUT
    puts program
end
