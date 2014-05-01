## Phase 1: sizing start and end

According to the pandoc manual, fenced code blocks are bit more complicated
than just lines of code enclosed by two lines starting with three tildes. For
one thing, the number of tildes might be longer than three. However, if so,
the ending line should start with, at least, as many tildes, although more are
allowed.

As code blocks cannot be nested — that just does not make sense —, we can
adapt the first phase bootstrapping program simply by remembering and testing
the number of tildes of the starting line. We introduce two functions to
determine if a line is a fence and, if so, what length that fence is.

~~~~~{.ruby}
DELIMITER = /^(?<fence>(?<prefix>~~~)~*).*$/

def is_fence?(line)
    DELIMITER.match(line)
end

def fence_size(line)
    DELIMITER.match(line)[:fence].size
end
~~~~~

Now, we adapt the program a bit.

~~~~~{.ruby}
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
~~~~~~~~~~~~~~~~
    
Observe how the program is getting harder to read and we have not incorporated
all the fence related rules yet. 
