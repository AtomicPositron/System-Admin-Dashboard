#!/bin/bash

clear

source ./utilis/fzf_pipe.sh
source ./utilis/input.sh

pipe_update_list() {
    figlet "Upgrade List" > ./pipe/upgrade_list.txt
    apt list --upgradable 2>/dev/null >> ./pipe/upgrade_list.txt
}

add_repository() {
    repository=$(input "Repository to add (format: ppa:user/ppa-name)")
    if [ -z "$repository" ]; then
        gum log --structured --level error "Repository cannot be empty" name ./log/admin.log
        return 1
    fi

    if sudo add-apt-repository -y "$repository"; then
        gum log --structured --level success "Successfully added repository: $repository" name ./log/admin.log
        return 0
    else
        gum log --structured --level error "Failed to add repository: $repository" name ./log/admin.log
        return 1
    fi
}

list_update() {
    updateList=('Update' 'Upgrade' 'Add_repository')
    IFS=$'\n'
    string="${updateList[*]}"

    selected_option=$(fzf_pipe "$string" ./pipe/upgrade_list.txt)

    case "$selected_option" in
        "Update")
            if sudo apt update; then
                gum log --structured --level success "Package list updated successfully" name ./log/admin.log
            else
                gum log --structured --level error "Failed to update package list" name ./log/admin.log
            fi
            ;;
        "Upgrade")
            if sudo apt upgrade -y; then
                gum log --structured --level success "System upgraded successfully" name ./log/admin.log
            else
                gum log --structured --level error "Failed to upgrade system" name ./log/admin.log
            fi
            ;;
        "Add_repository")
            add_repository
            ;;
        *)
            clear
            bash ./main.sh
            ;;
    esac
}

pipe_update_list
list_update
