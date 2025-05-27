#!/bin/bash

clear

source ./utilis/input.sh

pipe_data() {
    mpstat >./pipe/mpstat.txt
    ps aux | sort -nk 2 | head -n 31 >./pipe/process.txt
}

render_process() {
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 <./pipe/mpstat.txt
    gum style --border normal --margin "0 0" --padding "0 1" --width 160 <./pipe/process.txt
}

filter_search() {
    process=$(ps aux | fzf)

    case "$process" in
    *)
        clear
        bash ./modules/Process_managment.sh
        ;;
    esac
}
kill_process() {
    ps aux | fzf | awk '{print $2}' | xargs kill -9
}

enable_disable_process() {
    rm ./pipe/commandList.txt

    echo Enable >>./pipe/commandList.txt
    echo Disable >>./pipe/commandList.txt
    echo Back >>./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)
    case "$data" in
    Enable)
        service=$(input "Name Of the Service")
        sudo systemctl enable "$service".service
        ;;
    Disable)
        service=$(input "Name of the Service")
        sudo systemctl enable "$service".service

        ;;
    Back)
        clear
        bash ./modules/Process_managment.sh
        ;;
    *)
        gum log --structured --level error "Field Was not picked" name ./log/admin.log

        bash ./modules/Process_managment

        ;;

    esac
}
dependencies() {
    dependency=$(input "service name")

    systemctl list-dependencies "$dependency".service >>./pipe/dependencies.txt
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 <./pipe/dependencies.txt

    back=$(input "Press any key to go back")
    case "$back" in
    *)
        bash ./main.sh
        ;;
    esac
}
info() {
    # WARN: NOT WORKING
    systemctl >>./pipe/dependencies.txt
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 <./pipe/dependencies.txt

    back=$(input "Press any key to go back")
    case "$back" in
    *)
        bash ./main.sh
        ;;
    esac

}

process_managment() {
    rm ./pipe/commandList.txt

    echo Filter/Search >>./pipe/commandList.txt
    echo Kill >>./pipe/commandList.txt
    echo Enable/Disable >>./pipe/commandList.txt
    echo More_Information >>./pipe/commandList.txt
    echo Dependencies >>./pipe/commandList.txt
    echo Back >>./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case "$data" in
    Filter/Search)
        filter_search
        ;;
    kill)
        kill
        ;;
    More_information)
        info
        ;;
    Enable/Disable)
        enable_disable_process
        ;;
    Dependencies)
        dependencies
        ;;
    Back)
        bash ./main.sh
        ;;
    esac

}

pipe_data
render_process
process_managment
