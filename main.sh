#!/bin/bash

source ./utilis/fzf_pipe.sh
moduleList=('Network_Information' 'System_Information' 'Software_Update' 'Process_Managment' 'User_Managment')
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
*)
    clear
    echo ":) bye"
    ;;
esac
