#!/bin/bash

pandoc \
    --from markdown \
    --to html5 \
    --standalone \
    -o bootstrapping_foucault.html \
    doc-src/introduction.markdown \
    doc-src/phase_0.ruby.markdown \
    doc-src/phase_1.ruby.markdown \
    doc-src/phase_2.ruby.markdown
