#!/bin/bash

source ./scripts/init-vars.sh

# --- CONSTANTS ---
CL_PREFIX="cl_"

CL_CONTENT="sections/cl/content.tex"
CL_OPENING="sections/cl/closing.tex"
CL_CLOSING="sections/cl/opening.tex"
CL_RECIPIENT="sections/cl/recipient.tex"
CL_DATE="sections/cl/date.tex"

DIV_OPENING="opening"
DIV_CLOSING="closing"
DIV_MAIN="main"
DIV_DATE="date"
DIV_TITLE="title"
DIV_SUBTITLE="subtitle"

DEFAULT_DATE="\today"

# --- SCRIPT ---

# Check if the first argument is provided
if [ -z "$1" ]; then
    echo "$0: no argument provided."
    exit 1
fi

# Check if the argument is a valid file
if [ ! -f "$1" ]; then
    echo "$0: file dont exist"
    exit 2
fi

input="$1"
filename=$(echo "$1" | sed 's|.*/||; s|\.md||')

# Parsing datas
opening=$(get_div_content "$DIV_OPENING" "$input")
main=$(get_div_content "$DIV_MAIN" "$input")
closing=$(get_div_content "$DIV_CLOSING" "$input")
title=$(get_div_content "$DIV_TITLE" "$input")
subtitle=$(get_div_content "$DIV_SUBTITLE" "$input")
date=$(get_div_content "$DIV_DATE" "$input")

# Updating content
update_content "\opening{$opening}" $CL_OPENING
update_content "$main" $CL_CONTENT
update_content "\closing{$closing}" $CL_CLOSING
update_content "\date{$date}" $CL_DATE
update_content "\recipient{$title}{$subtitle}" $CL_RECIPIENT

# Update new lines for file that need
translate_newlines "$CL_RECIPIENT"

# Compiling
latexmk $LATEX_FLAGS $CL_FILE

# Copy output to document
cp "$OUT_DIR/$CL.pdf" "$DOC_DIR/$filename.pdf"
