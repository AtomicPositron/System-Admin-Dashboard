#!/bin/bash

source ./utilis/router.sh
gum spin --spinner dot --title "initialsing neofetch.." -- sleep 1
gum spin --spinner dot --title "initialsing duf.." -- sleep 1
gum spin --spinner dot --title "initialsing uptime.." -- sleep 1
gum spin --spinner dot --title "initialsing free.." -- sleep 1

update_screen() {
    neofetch >./pipe/neofetch.txt
    duf >./pipe/duf.txt
    uptime >./pipe/uptime.txt
    free >./pipe/free.txt
    clear
    neofetch_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 70 <./pipe/neofetch.txt)
    free_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 70 <./pipe/free.txt)
    duf_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 90 <./pipe/duf.txt)
    uptime_window=$(gum style --border normal --margin "0 0" --padding "1 2" --width 90 <./pipe/uptime.txt)
    join_Vertical=$(gum join --vertical "$duf_window" "$free_window" "$uptime_window")
    gum join --horizontal "$neofetch_window" "$join_Vertical"

    route "b" "main menu" ./admin_dashboard.sh
}
update_screen
