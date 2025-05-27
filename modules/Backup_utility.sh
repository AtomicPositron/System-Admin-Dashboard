#!/bin/bash
<<<<<<< HEAD
=======

source ./utilis/input.sh

menu(){
 rm ./cache/operation_cache.txt
 
 echo 'backup_a_directory' >>./cache/operation_cache.txt
 echo 'restore_from_backup' >>./cache/operation_cache.txt
 
 data=$(option ./cache/operation_cache.txt)
 
 case "$data" in
 backup_a_directory)
 	backup_files
 	;;
 restore_from_backup)
 	restore_files
 	;;
 esac  
 backup_files(){
 	directory=$(input "Directory name")
 	name=$(input "Name of backup folder")
 	gum spin --spinner dot --title "backing up $directory"
 	tar -czf "$name.tar.gz" "$directory"
 	
 	# TODO: add log here
}

restore_file(){
	past_file=$(input "Backup file to restore (with .tar.gz)")
	directory=$(input "restore directory")
	
	mkdir -p "$directory"
	tar -xzf "$past_file" -C "file"
	
	# TODO: add log here
}
>>>>>>> 982b696471056218b9a212a650877d8df5790e89
