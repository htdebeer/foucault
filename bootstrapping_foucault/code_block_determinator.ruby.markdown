~~~{.ruby}
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
~~~

## State machine to determinate lines 

The state machine to determinate code block lines is put in its own class.

~~~{.ruby}
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
~~~
