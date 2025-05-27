#!/bin/bash

source ./utilis/fzf_pipe.sh
moduleList=('Service_managment' 'Backup_Utility' 'Network_Information' 'System_Information' 'Software_Update' 'Process_Managment' 'User_Managment')
IFS=$'\n'
string="${moduleList[*]}"

selected_option=$(fzf_pipe "$string" README.md)

case "$selected_option" in
System_Information)
    bash ./modules/System_information.sh
    ;;
User_Managment)
    bash ./modules/User_managment.sh
    ;;
Software_Update)
    bash ./modules/System_Update.sh
    ;;
Process_Managment)
    bash ./modules/Process_managment.sh
    ;;
Network_Information)
    bash ./modules/Network_information.sh
    ;;
Backup_Utility)
    bash ./modules/Backup_utility.sh
    ;;
Service_managment)
    bash ./modules/Service_managment.sh
    ;;
*)
    clear
    echo ":) bye"
    ;;
esac
