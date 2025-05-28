#!/bin/bash

clear

source ./utilis/input.sh

pipe_data() {
    mpstat > ./pipe/mpstat.txt || gum log --structured --level error "Failed to get CPU stats" name ./log/admin.log
    ps aux | sort -nk 2 | head -n 31 > ./pipe/process.txt
}

render_process() {
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 < ./pipe/mpstat.txt
    gum style --border normal --margin "0 0" --padding "0 1" --width 160 < ./pipe/process.txt
}

filter_search() {
    process=$(ps aux | fzf)
    clear
    bash ./modules/Process_managment.sh
}

kill_process() {
    selected_process=$(ps aux | fzf)
    if [ -z "$selected_process" ]; then
        return
    fi

    pid=$(echo "$selected_process" | awk '{print $2}')
    if gum confirm "Kill process $pid?"; then
        if kill -9 "$pid"; then
            gum log --structured --level success "Successfully killed process $pid" name ./log/admin.log
        else
            gum log --structured --level error "Failed to kill process $pid" name ./log/admin.log
        fi
    fi
}

enable_disable_service() {
    rm -f ./pipe/commandList.txt

    echo "Enable" >> ./pipe/commandList.txt
    echo "Disable" >> ./pipe/commandList.txt
    echo "Back" >> ./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)
    case "$data" in
        Enable)
            service=$(input "Name of the Service")
            sudo systemctl enable "$service.service"
            ;;
        Disable)
            service=$(input "Name of the Service")
            sudo systemctl disable "$service.service"
            ;;
        Back)
            clear
            bash ./modules/Process_managment.sh
            ;;
        *)
            gum log --structured --level error "Invalid option selected" name ./log/admin.log
            bash ./modules/Process_managment.sh
            ;;
    esac
}

dependencies() {
    dependency=$(input "Service name")
    systemctl list-dependencies "$dependency.service" > ./pipe/dependencies.txt
    gum style --border normal --margin "1 1" --padding "0 1" --width 120 < ./pipe/dependencies.txt

    input "Press any key to go back"
    bash ./main.sh
}

process_management() {
    rm -f ./pipe/commandList.txt

    echo "Filter/Search" >> ./pipe/commandList.txt
    echo "Kill" >> ./pipe/commandList.txt
    echo "Enable/Disable" >> ./pipe/commandList.txt
    echo "Dependencies" >> ./pipe/commandList.txt
    echo "Back" >> ./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case "$data" in
        "Filter/Search")
            filter_search
            ;;
        "Kill")
            kill_process
            ;;
        "Enable/Disable")
            enable_disable_service
            ;;
        "Dependencies")
            dependencies
            ;;
        "Back")
            bash ./main.sh
            ;;
        *)
            gum log --structured --level error "Invalid option selected" name ./log/admin.log
            bash ./modules/Process_managment.sh
            ;;
    esac
}

pipe_data
render_process
process_management
