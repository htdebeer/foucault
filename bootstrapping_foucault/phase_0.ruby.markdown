## Phase 0: Simple Fenced Code Blocks

The simplest way to add a fenced code block is to use fences of exactly three
tildes.

    ~~~
    # say, like this.
    ~~~

To run a literate program, then, is to find a way to get the code out the
document and feed it to the compiler or interpreter. A simple way to go about
that, could be to inspect each line in the document. If the line is part of a
code block, keep it, if not, discard it.

Let us interpret a document as a sequence of lines. We use a simple state
machine with two states, *in code block* and *out code block*, starting in out
of code block. If we encounter a code block delimiter as defined above, i.e.,
a line starting with three tildes, we change state to in code block. In that
state, every next line will be collected into the runnable program. Whenever
we encounter the code block delimiter we will discard that line. Furthermore,
all lines outside a code block will be discarded as well.

~~~{.ruby}
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
~~~

Now, to test this simple program, we run it on this document. When running the
result, running it on this document, it should give the same result.

~~~{.ruby}
document = File.readlines ARGV[0]
program = program_collector document
puts program
~~~

Of course, this being the first document, the program to create a runnable
program from it does not yet exists. To that end, we bootstrap foucault by
copying all code in this document, by hand, to a separate file and run that.
