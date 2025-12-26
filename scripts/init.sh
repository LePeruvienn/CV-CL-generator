#!/bin/bash

# --- GLOBALS CONSTANTS ---

export NULL="NULL"

export CV="cv"
export CL="cl"

export CV_FILE="$CV.tex"
export CL_FILE="$CL.tex"

export BASE_DIR="$(pwd)"
export DOC_DIR="documents"
export TMP_DIR="tmp"
export IN_DIR="input"
export IN_CV_DIR="$IN_DIR/$CV"
export IN_CL_DIR="$IN_DIR/$CL"
export OUT_DIR="output"
export COMP_DIR="$OUT_DIR/components"
export CL_COMP_DIR="$COMP_DIR/$CL"
export CV_COMP_DIR="$COMP_DIR/$CV"

export LANG_FILE="$COMP_DIR/lang.tex"

export DEFAULT_CV_NAME="CV"
export DEFAULT_CL_NAME="CL"

export LATEX_FLAGS="-pdf -outdir=$OUT_DIR -interaction=nonstopmode"

# --- GLOBALS FUNCTIONS ---

get_input() {

    dir="$1"
    name="$2"
    input="$3"

    # If path is NULL we must find another file
    if [ "$NULL" == "$input" ]; then

        # Get all inputs files
        base="$(pwd)"
        cd "$dir"
        files=(*)
        cd "$BASE_DIR"
        
        # Filter if we can
        if [ "$NULL" != "$name" ]; then

            matched_files=()

            for file in "${files[@]}"; do
                if [[ "$file" == *"$name"* ]]; then
                    matched_files+=("$file")
                fi
            done

            files=("${matched_files[@]}")
        fi

        if [ ${#files[@]} -eq 1 ]; then
            input="$dir/${files[0]}"
        else
            select chosen_file in "${files[@]}"; do
                if [[ -n "$chosen_file" ]]; then
                    input="$dir/$chosen_file"
                    break
                fi
            done
        fi
    fi

    echo "$input"
}

update_lang() {
    update_content "\usepackage[$1]{babel}" $LANG_FILE
}

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
