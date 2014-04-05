DELIMITER = /^(?<fence>(?<prefix>~~~)~*).*$/

def is_fence?(line)
    DELIMITER.match(line)
end

def fence_size(line)
    DELIMITER.match(line)[:fence].size
end

def program_collector(document)
    program = []
    incode = false
    current_fence_size = 0

    while not document.empty? do

        line = document.shift

        if incode 

            if is_fence? line and fence_size(line) >= current_fence_size
                incode = false
                # End of the code block: ignore this line
                next
            else
                # Still in a code block: collect this line for the program
                program.push line
            end

        else
            # We're outside a code block

            if is_fence? line then
                incode = true
                current_fence_size = fence_size line
            end

            # the line is not part of the code, ignore it and go to the next one
            next

        end
    end

    program.join
end

document = File.readlines ARGV[0]
program = program_collector document
puts program
