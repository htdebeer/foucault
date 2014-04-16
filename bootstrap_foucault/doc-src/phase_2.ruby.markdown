## Phase 2: two kinds of fences

Not only tildes can make up a fence, also the backtick can do so if a line
starts with, at least, three backticks. This usage of the backtick to denote
code is different from denoting code inline with a single backtick.

So, the delimiter of a code block can contain of three or more tildes or
backticks. However, a block should end with the same symbols in the fence as
in the fence it started with. Besides keeping track of the size of a fence, we
should also keep track of the type of fence.

We could use these functions and adapt the original program, but the code will
only get more complex. Instead, think about determining code blocks
differently, not in the last place because there is another way to denote code
blocks in markdown alltogether. What we want to know, given the current state
and the current line: do we collect this line as part of the program or not?

One way to go about is to extend the state machine and add in what kind code
block we're dealing with. So, the initial state still is *out of code*, but to
get into a code block, we've got two options: a backtick fence or a tilde
fence. Besides keeping the state, we'll also keep track of the size of the
fence. Let us build that state machine.

~~~{.ruby}

class CodeBlockDeterminator

    def initialize()
        to_start_state
    end

    def collect_line?(line) 
        collect_line = false
        case @state
        when :fenced_block
            if is_fence?(line) and fence_size(line) >= @size and fence_type(line) == @type then
                 to_start_state 
            else
                collect_line = true
            end            
        when :start
            if is_fence?(line)
                @state = :fenced_block
                @type = fence_type line
                @size = fence_size line
            end
        end
        collect_line
    end

    private

    def to_start_state()
        @state = :start
        @size = 0
        @type = :none
    end

    FENCE = /^(?<fence>(?<type>~|`){3,}).*$/

    def is_fence?(line)
        FENCE.match line
    end

    def fence_size(line)
        FENCE.match(line)[:fence].size
    end

    def fence_type(line)
        FENCE.match(line)[:type]
    end

end
        
~~~

Using that state machine, the program becomes

~~~{.ruby}


def program_collector(document)
    program = []
    state_machine = CodeBlockDeterminator.new

    while not document.empty? do

        line = document.shift

        program.push line if state_machine.collect_line? line

    end

    program.join
end

document = File.readlines ARGV[0]
program = program_collector document
puts program
~~~
