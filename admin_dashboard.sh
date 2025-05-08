#!/bin/bash

source ./utilis/fzf_pipe.sh
moduleList=('System_Information' 'h' '')
IFS=$'\n'
string="${moduleList[*]}"

selected_option=$(fzf_pipe "$string" version.json)

case "$selected_option" in
System_Information)
    watch -t -n 1 bash ./modules/System_information.sh
    ;;
*)
    echo "p"
    ;;
esac
