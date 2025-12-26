#!/bin/bash

# Constants
source ./scripts/init-vars.sh
LM_CONTENT="sections/lm/content.tex"
LM_OPENING="sections/lm/closing.tex"
LM_CLOSING="sections/lm/opening.tex"

DIV_OPENING="opening"
DIV_CLOSING="closing"
DIV_MAIN="main"

get_div_content() {
    sed -n "/<$1>/,/<\/$1>/p" "$2" | sed "/<$1>/d;/<\/$1>/d"
}

translate() {
    sed -i 's/\*\*\([^*]*\)\*\*/\\textbf\{\1\}/g' $1
    sed -i 's/\*\([^*]*\)\*/\\textit\{\1\}/g' $1
}

update_content() {
    echo "$1" > $2
    translate $2
}


# Finding file
input="$(find input -name 'lm_*')"
filename=$(echo "$INPUT" | sed 's|.*/||; s|\.md||')

# Parsing datas
opening=$(get_div_content "$DIV_OPENING" "$input")
main=$(get_div_content "$DIV_MAIN" "$input")
closing=$(get_div_content "$DIV_CLOSING" "$input")

# Updating letter content
update_content "\opening{$opening}" $LM_OPENING
update_content "$main" $LM_CONTENT
update_content "\closing{$closing}" $LM_CLOSING

# Updating letter opening
#
# Updating letter closing


latexmk $LATEX_FLAGS $CL_FILE
