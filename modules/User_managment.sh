#!/bin/bash

clear

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

add_user() {
    userName=$(input "User name")
    userConfirmedPassword=$(password_auth)
    if [ "$userConfirmedPassword" = "404" ]; then
        gum log --structured --level error "Password not the same" name ./log/log.txt
        add_user
    else
        if gum confirm "Confirm Creating $userName"; then
            create_user "$userName" "$userConfirmedPassword"
            clear
            bash ./modules/User_managment.sh

        else
            clear
            bash ./main.sh
        fi
    fi
}

remover_user() {
    userName=$(input "User Name")
    if gum confirm "Confirm Deleting $userName"; then
        deluser "$userName"
        clear
        bash ./modules/User_managment.sh
    else
        clear
        bash ./main.sh
    fi
}

create_group() {
    groupName=$(input "groupName")
    gid=$(input "GID")
    if gum confirm "Confirm Creating $groupName"; then
        if [ "$gid" = "" ]; then
            if [ "$groupName" != "" ]; then
                groupadd "$groupName"
            else
                gum log --structured --level error "Group name not given" name ./log/log.txt
            fi
            clear
            bash ./modules/User_managment.sh
        else
            if [ "$groupName" != "" ]; then
                groupadd -g "$gid" "$groupName"
            else
                gum log --structured --level error "Group name not given" name ./log/log.txt
            fi
        fi
    else
        clear
        bash ./main.sh
    fi
}
delete_group() {
    groupName=$(input "Group Name")
    if gum confirm "Confirm Deleting Group $groupName"; then

        groupdel "$groupName"
    else
        clear
        bash ./modules/User_managment.sh
    fi
}
remove_user_group() {
    groupName=$(input "Group Name")
    userName=$(input "User Name")
    if gum confirm "Confirm Deleting $userName from Group $groupName"; then
        gpasswd --delete "$userName" "$groupName"
    else
        clear
        bash ./modules/User_managment.sh
    fi

}
add_user_group() {
    groupName=$(input "Group Name")
    UserName=$(input "User Name")
    if gum confirm "Confirm adding $UserName to Group $groupName"; then
        usermod --append --groups "$groupName" "$UserName"
    else
        clear
        bash ./modules/User_managment.sh
    fi
}
rename_group() {
    oldName=$(input "Old Name")
    newName=$(input "New Name")
    if gum confirm "Confirm Rename $oldName to $groupName"; then
        groupmod -n "$newName" "$oldName"
    else
        clear
        bash ./modules/User_managment.sh
    fi
}
change_id() {
    newGID=$(input "New GID")
    groupName=$(input "Group Name")
    if gum confirm "Confirm Change $groupName GID to $newGID"; then
        groupmod -g "$newGID" "$groupName"
    else
        clear
        bash ./modules/User_managment.sh
    fi
}

modify_group() {
    rm ./cache/operation_cache.txt

    echo Create >>./cache/operation_cache.txt
    echo Delete >>./cache/operation_cache.txt
    echo Remove_user >>./cache/operation_cache.txt
    echo Add_user >>./cache/operation_cache.txt
    echo Rename >>./cache/operation_cache.txt
    echo Change_Id >>./cache/operation_cache.txt

    data=$(option ./cache/operation_cache.txt)

    case "$data" in
    Create)
        create_group
        ;;
    Delete)
        delete_group
        ;;
    Remove_user)
        remove_user_group
        ;;
    Add_user)
        remove_user_group
        ;;
    Rename)
        rename_group
        ;;
    Change_Id)
        change_id
        ;;
    esac
}

lock_user() {
    userName=$(input "User Name")
    if gum confirm "Confirm Locking $UserName"; then
        passwd -l "$userName"
    else
        clear
        bash ./modules/User_managment.sh
    fi

}

unlock_user() {
    userName=$(input "User Name")
    passwd -u "$userName"

}

lock_status_user() {
    userName=$(input "User Name")
    if gum confirm "Confirm Locking $UserName"; then
        passwd -S "$userName"
    else
        clear
        bash ./modules/User_managment.sh
    fi

}

lock_unlock() {
    rm ./cache/operation_cache.txt

    echo Lock >>./cache/operation_cache.txt
    echo Unlock >>./cache/operation_cache.txt
    echo Lock_Status >>./cache/operation_cache.txt
    echo Back >>./cache/operation_cache.txt

    data=$(option ./cache/operation_cache.txt)

    case "$data" in
    Lock)
        lock_user
        ;;
    Unlock)
        unlock_user
        ;;
    Lock_Status)
        lock_status_user
        ;;
    "")
        gum log --structured --level error "Nothing Selected Or Function Not assigned to option" name ./log/log.txt
        bash ./module/User_managment.sh
        ;;
    *)
        gum log --structured --level error "Nothing Selected Or Function Not assigned to option" name ./log/log.txt
        bash ./module/User_managment.sh
        ;;

    esac
}

modify_user() {
    rm ./cache/operation_cache.txt

    echo Group >>./cache/operation_cache.txt
    echo Password >>./cache/operation_cache.txt
    echo Back >>./cache/operation_cache.txt

    data=$(option ./cache/operation_cache.txt)

    case "$data" in
    Group)
        modify_group
        ;;
    Password)
        modify_password
        ;;
    "")
        gum log --structured --level error "Nothing Selected Or Function Not assigned to option" name ./log/log.txt
        bash ./module/User_managment.sh
        ;;
    *)
        gum log --structured --level error "Nothing Selected Or Function Not assigned to option" name ./log/log.txt
        bash ./module/User_managment.sh
        ;;
    esac
}

command_list() {
    rm ./pipe/commandList.txt
    echo Add >>./pipe/commandList.txt
    echo Remove >>./pipe/commandList.txt
    echo Modify >>./pipe/commandList.txt
    echo Lock_Unlock >>./pipe/commandList.txt
    echo Menu >>./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case "$data" in
    Add)
        add_user
        ;;
    Remove)
        remover_user
        ;;
    Menu)
        bash ./main.sh
        ;;
    Modify)
        modify_user
        ;;
    Lock_Unlock)
        lock_unlock
        ;;

    "")
        bash ./main.sh
        ;;
    *)
        gum log --structured --level error "Nothing Selected Or Function Not assigned to option" name ./log/log.txt
        bash ./module/User_managment.sh
        ;;
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
