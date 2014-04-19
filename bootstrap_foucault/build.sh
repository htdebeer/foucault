#!/bin/bash

pandoc \
    --from markdown \
    --to html5 \
    --css=style.css \
    --toc \
    --standalone \
    -o bootstrapping_foucault.html \
    doc-src/frontmatter.markdown \
    doc-src/introduction.markdown \
    doc-src/phase_0.ruby.markdown \
    doc-src/phase_1.ruby.markdown \
    doc-src/phase_2.ruby.markdown \
    doc-src/code_block_determinator.ruby.markdown \
    doc-src/debugging.ruby.markdown
