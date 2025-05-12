#!/bin/bash

source ./utilis/input.sh
source ./utilis/router.sh

password_auth() {
    userPassword=$(password "User Password")
    userPassword_confirm=$(password "Confirm Password")

    if [ "$userPassword_confirm" = "$userPassword" ]; then
        echo "$userPassword_confirm"
    else
        echo "404"
    fi
}

create_user() {
    useradd "$1"
    chpasswd <<<"$1:$2"

}
bypass() {
    clear
    route "b" "main menu" ./admin_dashboard.sh
}

add_user() {
    userName=$(input "User name")
    userConfirmedPassword=$(password_auth)
    if [ "$userConfirmedPassword" = "404" ]; then
        gum log --structured --level error "Password not the same" name ./log/log.txt
        add_user
    else
        if gum confirm "Confirm User $userName"; then
            create_user "$userName" "$userConfirmedPassword"
            bash ./modules/User_managment.sh

        else
            bypass
        fi
    fi
}

command_list() {
    rm ./pipe/commandList.txt
    echo Add >>./pipe/commandList.txt
    echo Remove >>./pipe/commandList.txt
    echo Modify >>./pipe/commandList.txt
    echo Lock/Unlock >>./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case "$data" in
    Add)
        add_user
        ;;
    *) ;;
    esac
}
pipe_user_data() {
    awk -F: '$3 >= 1000 && $3 < 65534 {printf "%-10s UID: %-3s GID: %-3s Home: %-15s Shell: %s\n", $1, $3, $4, $6, $7}' /etc/passwd >./pipe/human.txt
}

render_data() {
    left_pane=$(gum style --border normal --margin "0 0" --padding "0 1" --width 90 <./pipe/human.txt)

    right_top_pane=$(gum style --border normal --margin "0 0" --padding "2 2" --width 70 <./pipe/userCommands.txt)

    right_pane=$(gum join --vertical "$right_top_pane")

    gum join --horizontal "$left_pane" "$right_pane"
}

pipe_user_data
render_data
command_list
