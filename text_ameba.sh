#!/bin/bash

#################################
# test-ameba
#################################

process_input() {
    local IFS=$'\n'
    local output=""
    local first=true
    while IFS= read -r line; do
        if [ "$line" = "end" ]; then
            break
        fi

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

    echo -e "\n( ´･ω･)⊃ ｽｯ \n\n$output"
    echo -e "$output" | copy_to_clipboard
}
    
copy_to_clipboard() {
    if command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard
	echo -e "\nクリップボードにコピーしました。\n"
    elif command -v pbcopy >/dev/null 2>&1; then
        pbcopy
        echo -e "\nクリップボードにコピーしました。\n"
    else
        echo -e "\nクリップボードにコピーできませんでした。xclip または pbcopy がインストールされていません。\n"
        return 1
    fi
}

text_ameba() {
    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    echo -e "\nテキストを入力してください (終了の場合は'end'と入力しEnterキーを押してください。)\n"
    process_input
}

