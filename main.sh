#!/bin/bash

source ./utilis/fzf_pipe.sh
moduleList=('System_Information' 'User_Managment')
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
*)
    clear
    echo ":) bye"
    ;;
esac
