


class CodeBlockDeterminator

    def initialize()
        to_start_state
    end

    def collect_line?(line) 

        case @state

        when :fenced_block
            if is_fence?(line) and fence_size(line) >= @size and fence_type(line) == @type then
                 # recognized the end of this code block
                 to_start_state 
            else
                # We're still in a code block: collect this line
                return true
            end            

        when :start
            if is_fence?(line)
                # Start of a new code block
                @state = :fenced_block
                @type = fence_type line
                @size = fence_size line
            end
        end
        
        # not in a code block: don't collect this line
        return false
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
        
