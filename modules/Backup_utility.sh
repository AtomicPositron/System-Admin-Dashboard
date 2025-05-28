#!/bin/bash

source ./utilis/input.sh

clear

backup_files() {
    directory=$(input "Directory name")
    if [ ! -d "$directory" ]; then
        gum log --structured --level error "Directory does not exist: $directory" name ./log/admin.log
        return 1
    fi

    name=$(input "Name of backup folder")
    if tar -czf "$name.tar.gz" "$directory"; then
        gum log --structured --level success "Successfully backed up $directory to $name.tar.gz" name ./log/admin.log
    else
        gum log --structured --level error "Failed to create backup" name ./log/admin.log
        return 1
    fi
}

restore_file() {
    past_file=$(input "Backup file to restore (with .tar.gz)")
    if [ ! -f "$past_file" ]; then
        gum log --structured --level error "Backup file not found: $past_file" name ./log/admin.log
        return 1
    fi

    directory=$(input "Restore directory")
    mkdir -p "$directory"
    
    if tar -xzf "$past_file" -C "$directory"; then
        gum log --structured --level success "Successfully restored $past_file to $directory" name ./log/admin.log
    else
        gum log --structured --level error "Failed to restore backup" name ./log/admin.log
        return 1
    fi
}

menu() {
    rm -f ./cache/operation_cache.txt

    echo 'Backup' >> ./cache/operation_cache.txt
    echo 'Restore' >> ./cache/operation_cache.txt
    echo 'Back' >> ./cache/operation_cache.txt

    data=$(option ./cache/operation_cache.txt)

    case "$data" in
        Backup)
            backup_files
            ;;
        Restore)
            restore_file
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
