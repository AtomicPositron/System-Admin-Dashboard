#!/bin/bash

clear

pipe_data() {
    mpstat >./pipe/mpstat.txt
    ps aux | sort -nk 2 | head -n 31 >./pipe/process.txt
}

render_process() {
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 <./pipe/mpstat.txt
    gum style --border normal --margin "0 0" --padding "0 1" --width 160 <./pipe/process.txt
}

process_managment() {
    rm ./pipe/commandList.txt

    echo Filter >>./pipe/commandList.txt
    echo Services >>./pipe/commandList.txt
    echo More_Information >>./pipe/commandList.txt
    echo Dependencies >>./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)
}

#kill_process() {}

pipe_data
render_process
