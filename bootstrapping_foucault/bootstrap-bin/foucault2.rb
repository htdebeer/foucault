
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
