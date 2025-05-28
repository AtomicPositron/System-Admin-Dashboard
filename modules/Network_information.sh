#!/bin/bash

source ./utilis/input.sh

clear

pipe_network() {
    # Run network commands in parallel
    (nmcli device show > ./pipe/nmcli_device.txt 2>/dev/null) &
    (nmcli connection show > ./pipe/nmcli_connection.txt 2>/dev/null) &
    (dig > ./pipe/dig.txt 2>/dev/null) &
    (ip -s stats > ./pipe/ip_stats.txt 2>/dev/null) &
    (ip route > ./pipe/ip_route.txt 2>/dev/null) &
    (ip link > ./pipe/ip_link.txt 2>/dev/null) &
    (ip address > ./pipe/ip_address.txt 2>/dev/null) &
    (sar -n DEV 1 1 > ./pipe/sar.txt 2>/dev/null) &
    (arp -n > ./pipe/arp.txt 2>/dev/null) &
    wait
}

render_network() {
    nmcli_device_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/nmcli_device.txt)
    nmcli_connection=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/nmcli_connection.txt)
    dig_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/dig.txt)
    ip_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/ip_address.txt)
    ip_stats_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/ip_stats.txt)
    ip_route_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/ip_route.txt)
    ip_link_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/ip_link.txt)
    sar_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/sar.txt)
    arp_window=$(gum style --border normal --margin "0 0" --padding "0 1" --width 80 < ./pipe/arp.txt)

    right_pane=$(gum join --vertical "$nmcli_device_window" "$ip_stats_window" "$nmcli_connection" "$sar_window")
    left_pane=$(gum join --vertical "$ip_window" "$ip_link_window" "$ip_route_window" "$dig_window" "$arp_window")

    gum join --horizontal "$right_pane" "$left_pane"
}

pipe_network
render_network

input "Press any key to go back"
bash ./main.sh
