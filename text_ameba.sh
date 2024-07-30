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
    echo -e "\n( ´･ω･)⊃ ｽｯ \n$output"
    echo -e "$output" | copy_to_clipboard
}

copy_to_clipboard() {
    if command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard
    elif command -v pbcopy >/dev/null 2>&1; then
        pbcopy
        echo -e "\nクリップボードにコピーされました。"
    else
        echo "クリップボードにコピーできませんでした。xclipまたはpbcopyがインストールされていません。"
        return 1
    fi
}

text_ameba() {
    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    echo -e "\nテキストを入力してください（入力を終了するには、改行してCtrl+Dを押してください）\n"
    process_input
}

