#!/bin/bash

input() {
    data=$(gum input --placeholder "$1")
    echo "$data"
}

password() {
    data=$(gum input --password --placeholder "$1")
    echo "$data"
}

option() {
    data=$(gum filter --height 10 --limit 1 <"$1")
    echo "$data"
}
