#!/bin/bash

#################################
# test-ameba
#################################

process_input() {
    local IFS=$'\n'
    local output=""
    local first=true
    while read -r line; do
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        if [ -n "$line" ]; then
            if [ "$first" = true ]; then
                output="'$line'"
                first=false
            else
                output="$output,\n'$line'"
            fi
        fi
    done
    echo -e "\n( ´･ω･)⊃ Here you go \n$output"
    echo -e "$output" | copy_to_clipboard
}

copy_to_clipboard() {
    if command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard
    elif command -v pbcopy >/dev/null 2>&1; then
        pbcopy
        echo -e "\nCopied to clipboard."
    else
        echo "Could not copy to clipboard. xclip or pbcopy is not installed."
        return 1
    fi
}

text_ameba() {
    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    echo -e "\nPlease enter text (to finish input, press Enter and then Ctrl+D)\n"
    process_input
}

