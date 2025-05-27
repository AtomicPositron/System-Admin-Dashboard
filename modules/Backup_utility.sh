#!/bin/bash

source ./utilis/input.sh

clear

backup_files() {
    directory=$(input "Directory name")
    name=$(input "Name of backup folder")
    tar -czf "$name.tar.gz" "$directory"

    gum log --structured --level error "Backed up files" name ./log/admin.log
}

restore_file() {
    past_file=$(input "Backup file to restore (with .tar.gz)")
    directory=$(input "restore directory")

    mkdir -p "$directory"
    tar -xzf "$past_file" -C "file"
    gum log --structured --level error "Restore file" name ./log/admin.log
}

menu() {
    rm ./cache/operation_cache.txt

    echo 'Backup' >>./cache/operation_cache.txt
    echo 'Restore' >>./cache/operation_cache.txt
    echo 'Back' >>./cache/operation_cache.txt

    data=$(option ./cache/operation_cache.txt)

    case "$data" in
    Backup)
        backup_files
        ;;
    Restore)
        restore_files
        ;;
    Back)
        bash ./main.sh
        ;;
    *)
        bash ./main.sh
        ;;
    esac
}
menu
