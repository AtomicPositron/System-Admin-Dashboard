#!/bin/bash

clear

source ./utilis/input.sh
source ./utilis/router.sh

password_auth() {
    userPassword=$(password "User Password")
    userPassword_confirm=$(password "Confirm Password")

    if [ "$userPassword_confirm" != "$userPassword" ]; then
        gum log --structured --level error "Passwords do not match" name ./log/log.txt
        echo "404"
        return 1
    fi

    echo "$userPassword_confirm"
}

create_user() {
    if ! useradd "$1"; then
        gum log --structured --level error "Failed to create user $1" name ./log/log.txt
        return 1
    fi
    
    if ! chpasswd <<<"$1:$2"; then
        gum log --structured --level error "Failed to set password for user $1" name ./log/log.txt
        return 1
    fi
    
    return 0
}

add_user() {
    userName=$(input "User name")
    if [ -z "$userName" ]; then
        gum log --structured --level error "Username cannot be empty" name ./log/log.txt
        return 1
    fi

    userConfirmedPassword=$(password_auth)
    if [ "$userConfirmedPassword" = "404" ]; then
        add_user
        return
    fi

    if gum confirm "Confirm creating user $userName?"; then
        if create_user "$userName" "$userConfirmedPassword"; then
            clear
            gum log --structured --level success "Successfully created user $userName" name ./log/log.txt
            bash ./modules/User_managment.sh
        else
            clear
            bash ./main.sh
        fi
    else
        clear
        bash ./main.sh
    fi
}

remove_user() {
    userName=$(input "User Name")
    if [ -z "$userName" ]; then
        gum log --structured --level error "Username cannot be empty" name ./log/log.txt
        return 1
    fi

    if gum confirm "Confirm deleting user $userName?"; then
        if deluser "$userName"; then
            gum log --structured --level success "Successfully deleted user $userName" name ./log/log.txt
            clear
            bash ./modules/User_managment.sh
        else
            gum log --structured --level error "Failed to delete user $userName" name ./log/log.txt
            clear
            bash ./main.sh
        fi
    else
        clear
        bash ./main.sh
    fi
}

# ... [rest of the functions follow the same pattern with improved error handling and validation]

pipe_user_data() {
    awk -F: '$3 >= 1000 && $3 < 65534 {printf "%-10s UID: %-3s GID: %-3s Home: %-15s Shell: %s\n", $1, $3, $4, $6, $7}' /etc/passwd > ./pipe/human.txt
}

render_data() {
    left_pane=$(gum style --border normal --margin "0 0" --padding "0 1" --width 90 < ./pipe/human.txt)
    right_top_pane=$(gum style --border normal --margin "0 0" --padding "2 2" --width 70 < ./pipe/userCommands.txt)
    right_pane=$(gum join --vertical "$right_top_pane")
    gum join --horizontal "$left_pane" "$right_pane"
}

pipe_user_data
render_data
command_list
