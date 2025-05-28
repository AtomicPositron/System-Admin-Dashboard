#!/bin/bash

source ./utilis/input.sh

process_list() {
    rm -f ./pipe/commandList.txt

    echo "Start_Services" > ./pipe/commandList.txt
    echo "Stop_Services" > ./pipe/commandList.txt
    echo "Restart_Services" > ./pipe/commandList.txt
    echo "Back" > ./pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case "$data" in
        "Start_Services")
            service=$(input "Enter service name to start")
            if sudo systemctl start "$service"; then
                gum log --structured --level success "Started service $service" name ./log/admin.log
            else
                gum log --structured --level error "Failed to start service $service" name ./log/admin.log
            fi
            ;;
        "Stop_Services")
            service=$(input "Enter service name to stop")
            if sudo systemctl stop "$service"; then
                gum log --structured --level success "Stopped service $service" name ./log/admin.log
            else
                gum log --structured --level error "Failed to stop service $service" name ./log/admin.log
            fi
            ;;
        "Restart_Services")
            service=$(input "Enter service name to restart")
            if sudo systemctl restart "$service"; then
                gum log --structured --level success "Restarted service $service" name ./log/admin.log
            else
                gum log --structured --level error "Failed to restart service $service" name ./log/admin.log
            fi
            ;;
        "Back")
            bash ./main.sh
            ;;
        *)
            gum log --structured --level error "Invalid option selected" name ./log/admin.log
            bash ./main.sh
            ;;
    esac
}

process_list
