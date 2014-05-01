# Bootstrapping Foucault

## Introduction

Foucault extracts the code from literate programs written in markdown. There
are three ways to add code to a markdown document:

1. indented code blocks: a sequence of lines indented with four spaces or a tab on top
   of the current indentation and enclosed by blank lines is treated as code.
   For example:

        while true do
            puts "I am a code block"
        end

2. inline code: text enclosed by \`'s is treaded as piece of code. For
   example, `x = x + 1 if x < 100`.

3. fenced code blocks: all lines in between two 'fences' are treated as code.
   A fence is a line starting with, at least, three tildes (`~`) or tick marks
   (`\``). The top fence is preceded by a blank line and the bottom fence is
   followed by a blank line. Furthermore, the bottom fence should start with
   at least the same amount and type of fence characters. For example:

~~~
start = '~~~'
while line =~ /^~~~.*/ do
    puts "line is a code line"
    line = next line
end
~~~~~

Foucault extracts only code inside fenced code blocks, allowing the literate
programmer to write about code without writing code by using indented code
blocks or, when a very short piece of code, inline code.

Foucault is written as a literate program; this document is the foucault
program. There is one problem, however, how can foucault's code be
extracted from this document with foucault? It does not yet exist!

The solution is called *bootstrapping*. We create a simple executable program
that can extract code from this document that, itself, is not a literate
program. Of course, once that program is created, it can be added to this
document as well, allowing it to extract itself. In this section the
bootstrapping process is described in three phases.
