#!/bin/bash

clear

source ./utilis/router.sh

update_screen() {
    # Run commands in parallel to speed up execution
    (neofetch > ./pipe/neofetch.txt 2>/dev/null) &
    (duf > ./pipe/duf.txt 2>/dev/null) &
    (uptime > ./pipe/uptime.txt 2>/dev/null) &
    (free -h > ./pipe/free.txt 2>/dev/null) &
    wait

    clear

    neofetch_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 70 < ./pipe/neofetch.txt)
    free_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 70 < ./pipe/free.txt)
    duf_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 90 < ./pipe/duf.txt)
    uptime_window=$(gum style --border normal --margin "0 0" --padding "1 2" --width 90 < ./pipe/uptime.txt)
    
    join_Vertical=$(gum join --vertical "$duf_window" "$free_window" "$uptime_window")
    gum join --horizontal "$neofetch_window" "$join_Vertical"

    route "b" "main menu" ./admin_dashboard.sh
}

update_screen
