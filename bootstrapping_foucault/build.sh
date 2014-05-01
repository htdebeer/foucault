#!/bin/bash
# Use pandoc <http://johnmacfarlane.net/pandoc/index.html> to generate
# readable version of the literate program foucault
pandoc \
    --from markdown \
    --to html5 \
    --css=style.css \
    --toc \
    --standalone \
    -o ../bootstrapping_foucault.html \
    frontmatter.markdown \
    introduction.markdown \
    phase_0.ruby.markdown \
    phase_1.ruby.markdown \
    phase_2.ruby.markdown \
    code_block_determinator.ruby.markdown \
    debugging.ruby.markdown
