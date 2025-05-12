#!/bin/bash

route() {
    result=$(gum input --placeholder "Press $1 for $2 or q to quit")

    case "$result" in
    "$1")
        clear
        bash "$3"
        ;;
    q)
        clear
        exit 1
        ;;
    esac
}
