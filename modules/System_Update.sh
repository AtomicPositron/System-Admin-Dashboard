#!/bin/bash
clear

source ./utilis/fzf_pipe.sh
source ./utilis/input.sh
pipe_update_list() {
    figlet Upgrade List >./pipe/upgrade_list.txt
    apt list --upgradable >./pipe/upgrade_list.txt
}

adding_repository() {
    # TODO: Fix this repository

    sudo apt add-apt-repository "$1"
}

list_Update() {
    updateList=('Update' 'Upgrade' 'Add_repository')
    IFS=$'\n'
    string="${updateList[*]}"

    selected_option=$(fzf_pipe "$string" ./pipe/upgrade_list.txt)

    case "$selected_option" in
    Update)
        sudo apt install update
        ;;
    Upgrade)
        sudo apt install upgrade
        ;;
    Add_repository)
        response=$(input "<REPO NAME>")
        adding_repository "$response"
        ;;
    *)
        clear
        bash ./main.sh
        ;;
    esac
}

pipe_update_list
list_Update
