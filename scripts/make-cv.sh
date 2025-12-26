#!/bin/bash
source ./scripts/init.sh

# --- CONSTANTS ---

CV_TITLE="$CV_COMP_DIR/title.tex"
CV_PROFILE="$CV_COMP_DIR/profile.tex"

DIV_TITLE="title"
DIV_PROFILE="profile"

# --- SCRIPT ---

name="$1"
path="$2"
lang="$3"

# update lang
update_lang "$lang"

# Get input
input="$(get_input $IN_CV_DIR $name $path)"

echo "INPUT FILE: $input"

# Check if the input is a valid file
if [ ! -f "$input" ]; then
    echo "$0: $input file dont exist."
    exit 2
fi

filename=$(echo "$input" | sed 's|.*/||; s|\.md||')

title=$(get_div_content "$DIV_TITLE" "$input")
profile=$(get_div_content "$DIV_PROFILE" "$input")

update_content "\title{$title}" $CV_TITLE
update_content "$profile" $CV_PROFILE

# Compiling
latexmk $LATEX_FLAGS $CV_FILE

# Copy output to document
cp "$OUT_DIR/$CV.pdf" "$DOC_DIR/$CV-$filename.pdf"
