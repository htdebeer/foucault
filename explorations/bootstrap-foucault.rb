#!/usr/bin/env ruby
CODE_BLOCK_DELIMITER = /^~~~.*$/

def program_collector(document)
    program = []
    incode = false
    while not document.empty? do
        line = document.shift
        if line =~ CODE_BLOCK_DELIMITER then
            incode = ! incode
            next 
        end

        program.push line if incode
    end

    program.join
end

document = File.readlines ARGV[0]
program = program_collector document
puts program
