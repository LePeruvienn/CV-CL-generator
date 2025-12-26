#!/bin/bash
source ./scripts/init.sh

# --- CONSTANTS ---


# --- SCRIPT ---

name="$1"
path="$2"
lang="$3"

# update lang
update_lang "$lang"

# Get input
input="$(get_input $IN_CL_DIR $name $path)"

echo "INPUT FILE: $input"

# Check if the input is a valid file
if [ ! -f "$input" ]; then
    echo "$0: $input file dont exist."
    exit 2
fi

filename=$(echo "$input" | sed 's|.*/||; s|\.md||')

# Compiling
latexmk $LATEX_FLAGS $CV_FILE

# Copy output to document
cp "$OUT_DIR/$CV.pdf" "$DOC_DIR/$CV-$filename.pdf"
