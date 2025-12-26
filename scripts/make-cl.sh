#!/bin/bash

# --- CONSTANTS ---

source ./scripts/init-vars.sh
LM_CONTENT="sections/lm/content.tex"
LM_OPENING="sections/lm/closing.tex"
LM_CLOSING="sections/lm/opening.tex"
LM_RECIPIENT="sections/lm/recipient.tex"
LM_DATE="sections/lm/date.tex"

DIV_OPENING="opening"
DIV_CLOSING="closing"
DIV_MAIN="main"
DIV_DATE="date"
DIV_TITLE="title"
DIV_SUBTITLE="subtitle"

DEFAULT_DATE="\today"

# --- FUNCTIONS ---

source ./scripts/init-vars.sh
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

# --- SCRIPT ---

# Finding file
input="$(find input -name 'lm_*')"
filename=$(echo "$INPUT" | sed 's|.*/||; s|\.md||')

# Parsing datas
opening=$(get_div_content "$DIV_OPENING" "$input")
main=$(get_div_content "$DIV_MAIN" "$input")
closing=$(get_div_content "$DIV_CLOSING" "$input")
title=$(get_div_content "$DIV_TITLE" "$input")
subtitle=$(get_div_content "$DIV_SUBTITLE" "$input")
date=$(get_div_content "$DIV_DATE" "$input")

# Updating content
update_content "\opening{$opening}" $LM_OPENING
update_content "$main" $LM_CONTENT
update_content "\closing{$closing}" $LM_CLOSING
update_content "\date{$date}" $LM_DATE
update_content "\recipient{$title}{$subtitle}" $LM_RECIPIENT

# Update new lines for file that need
translate_newlines "$LM_RECIPIENT"

# Compiling
latexmk $LATEX_FLAGS $CL_FILE
