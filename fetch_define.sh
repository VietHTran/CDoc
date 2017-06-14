#!/bin/bash

C_FILES=$(find . -type f -name "*.c")
H_FILES=$(find . -type f -name "*.h")

for file in $H_FILES; do
    #echo "file: $file"
    while read line; do
        #skip blank lines
        if [ -z "$line" ] || [ "$line" = *[[:space:]]* ]; then
            continue
        fi
        #get lines with define macro
        if [[ "$line" == \#define* ]]; then
            echo "$line"
        fi
    done <"$file"
done
