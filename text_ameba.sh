#!/bin/bash

#################################
# test-ameba
#################################

select_option() {
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "  $1  "; }
    print_selected()   { printf "> $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                        if [[ $key = $ESC[A ]]; then echo up;    fi
                        if [[ $key = $ESC[B ]]; then echo down;  fi
                        if [[ $key = ""     ]]; then echo enter; fi; }

    local options=("$@")
    local selected=0
    local current_row
    current_row=$(get_cursor_row)

    cursor_blink_off

    while true; do
        for i in "${!options[@]}"; do
            cursor_to $(($current_row + $i))
            if [ $i -eq $selected ]; then
                print_selected "${options[$i]}"
            else
                print_option "${options[$i]}"
            fi
        done

        case $(key_input) in
            up)    ((selected--));
                    if [ $selected -lt 0 ]; then selected=$((${#options[@]} - 1)); fi;;
            down)  ((selected++));
                    if [ $selected -ge ${#options[@]} ]; then selected=0; fi;;
            enter) break;;
        esac
    done

    cursor_to $current_row
    printf "\n"
    cursor_blink_on

    return $selected
}



process_text_input() {
    printf '\033[H\033[2J'

    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    echo -e "\nテキストを入力してください (終了の場合は'end'と入力しEnterキーを押してください。)\n"

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
    printf '\033[H\033[2J'

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



process_file_input() {
    printf '\033[H\033[2J'
    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    echo -e "\nインプットを行うファイルのパスを入力してください (相対パスでも大丈夫です)\n"
    read -p "> " input_file

    input_file="${input_file/#\~/$HOME}"
    input_file="$(realpath "$input_file")"

    if [ -f "$input_file" ]; then

        output_dir="$HOME/text_ameba"
        if [ ! -d "$output_dir" ]; then
            mkdir -p "$output_dir"
        fi

        timestamp=$(date +"%Y%m%d_%H%M%S")

        > "$output_file"


        total_lines=$(awk 'BEGIN { count = 0 } NF > 0 {count++} END {print count}' "$input_file")

        awk -v total_lines="$total_lines" '
            BEGIN {
                count = 0
            }
            NF > 0 {

                printf "\x27%s\x27", $0
                
                if (count < total_lines-1 ) {
                    printf ",\n"
                    count++
                }
            }
            END {
                printf "\n"
            }
        ' "$input_file" > "$output_file"

        echo "処理が完了しました。結果は $output_file に保存されています。"
    
    else
        echo "エラー: ファイル '$input_file' が存在しません。"
    fi
}


text_ameba() {
    printf '\033[H\033[2J'
    echo "==========================="
    echo "=   t e x t - a m e b a   ="
    echo "==========================="
    options=("テキスト入力" "ファイル読み込み" "終了")
    select_option "${options[@]}"
    choice=$?
    case $choice in
        0) process_text_input ;;
        1) process_file_input ;;
        2) echo "";;
    esac
}

