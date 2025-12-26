#!/bin/bash

# --- GLOBALS CONSTANTS ---

export CV="cv"
export CL="cl"
export CV_FILE="cv.tex"
export CL_FILE="cl.tex"

export DOC_DIR="documents"
export TMP_DIR="tmp"
export IN_DIR="input"
export OUT_DIR="output"

export DEFAULT_CV_NAME="CV"
export DEFAULT_CL_NAME="CL"

export LATEX_FLAGS="-pdf -outdir=$OUT_DIR -interaction=nonstopmode"

# --- GLOBALS FUNCTIONS ---

get_div_content() {
    sed -n "/<$1>/,/<\/$1>/p" "$2" | sed "/<$1>/d;/<\/$1>/d"
}

translate_style() {
    sed -i 's/\*\*\([^*]*\)\*\*/\\textbf\{\1\}/g' "$1"
    sed -i 's/\*\([^*]*\)\*/\\textit\{\1\}/g' "$1"
}

translate_newlines() {
    sed -i ':a;N;$!ba;s/\n/\\\\/g' "$1"
}

update_content() {
    echo "$1" > $2
    translate_style $2
}
