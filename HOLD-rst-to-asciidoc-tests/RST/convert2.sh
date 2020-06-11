#!/bin/bash

find . -name \*.rst -type f -exec pandoc --from rst --to asciidoc --standalone -o {}.adoc {} \;

