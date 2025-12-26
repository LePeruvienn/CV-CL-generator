#!/bin/bash

source ./scripts/init-vars.sh

# --- CONSTANTS ---
CL_PREFIX="cl_"

CL_CONTENT="$CL_COMP_DIR/content.tex"
CL_OPENING="$CL_COMP_DIR/closing.tex"
CL_CLOSING="$CL_COMP_DIR/opening.tex"
CL_RECIPIENT="$CL_COMP_DIR/recipient.tex"
CL_DATE="$CL_COMP_DIR/date.tex"

DIV_OPENING="opening"
DIV_CLOSING="closing"
DIV_MAIN="main"
DIV_DATE="date"
DIV_TITLE="title"
DIV_SUBTITLE="subtitle"

DEFAULT_DATE="\today"

# --- SCRIPT ---

name="$1"
path="$2"
lang="$3"

# Get input
input="$(get_input $IN_CL_DIR $name $path)"

echo "INPUT FILE: $input"

# Check if the input is a valid file
if [ ! -f "$input" ]; then
    echo "$0: $input file dont exist."
    exit 2
fi

filename=$(echo "$input" | sed 's|.*/||; s|\.md||')

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
cp "$OUT_DIR/$CL.pdf" "$DOC_DIR/$CL-$filename.pdf"
