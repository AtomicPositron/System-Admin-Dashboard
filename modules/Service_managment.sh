#!/bin/bash

source ./utilis/input.sh

process_list() {
    rm ./pipe/commandList.txt

    echo Start_Services >.pipe/commandList.txt
    echo Stop_Services >.pipe/commandList.txt
    echo Restart_Services >.pipe/commandList.txt
    echo Back >.pipe/commandList.txt

    data=$(option ./pipe/commandList.txt)

    case $data in
    Start_Services)
        s=$(input "Enter service name to start")
        sudo systemctl start "$s"
        ;;
    Stop_Services)
        s=$(input "Enter service name to stop")
        sudo systemctl stop "$s"
        ;;
    Restart_Services)
        s=$(input "Enter service name to restart")
        sudo systemctl restart "$s"
        ;;
    Back)
        bash ./main.sh
        ;;

    *)
        gum log --structured --level error "Field Was not picked" name ./log/admin.log

        bash ./main.sh
        ;;
    esac

}
