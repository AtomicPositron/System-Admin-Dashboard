case $data in
        1)
            systemctl list-units --type=service
            echo "$(date): Listed all services" >> "$LOG_FILE"
            ;;
        2)
            read -p "Enter service name to start: " s
            sudo systemctl start "$s"
            echo "$(date): Started service $s" >> "$LOG_FILE"
            ;;
        3)
            read -p "Enter service name to stop: " s
            sudo systemctl stop "$s"
            echo "$(date): Stopped service $s" >> "$LOG_FILE"
            ;;
        4)
            read -p "Enter service name to restart: " s
            sudo systemctl restart "$s"
            echo "$(date): Restarted service $s" >> "$LOG_FILE"
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac

    read -p "Press Enter to return to menu..."
}
