#!/bin/bash

C_FILES=$(find . -type f -name "*.c")
H_FILES=$(find . -type f -name "*.h")

DEFINE_RE=\#define*
IFDEF_RE=\#ifdef*
IFNDEF_RE=\#ifndef*
ELIF_RE="\#elif*"
ENDIF_RE=\#endif*
INCLUDE_RE=\#include*


for file in $H_FILES; do
    line_num=0
    #echo "file: $file"
    while read line; do
        line_num=$((line_num+1))
        #skip blank lines
        if [ -z "$line" ] || [ "$line" = *[[:space:]]* ]; then
            continue
        fi
        RE=$INCLUDE_RE
        case "$1" in
            --def)
                RE=$DEFINE_RE
                ;&
            --map)
                if [[ "$line" == $RE ]]; then
                    echo "$file:$line_num $line"
                fi
                ;;
            --if)
                #get lines with ifdef, ifndef, endif, elif
                if [[ "$line" == $IFDEF_RE ]]; then
                    echo "$file:$line_num $line"
                elif [[ "$line" == $IFNDEF_RE ]]; then
                    echo "$file:$line_num $line"
                elif [[ "$line" == $ELIF_RE ]]; then
                    echo "$file:$line_num $line"
                elif [[ "$line" == $ENDIF_RE ]]; then
                    echo "$file:$line_num $line"
                fi
                ;;
        esac
    done <"$file"
done
