# System Administration Toolkit

![Bash](https://img.shields.io/badge/Shell-Bash-green)
![Gum](https://img.shields.io/badge/TUI-Gum-blue)
![License](https://img.shields.io/badge/License-MIT-orange)

A comprehensive suite of Bash scripts for Linux system administration with a user-friendly terminal interface.

## Features

- **User Management**: Create, modify, and delete users/groups
- **Process Control**: Monitor and manage running processes
- **Service Management**: Start/stop/restart system services
- **Backup Utility**: Create and restore compressed backups
- **System Monitoring**: Real-time system resource monitoring
- **Network Tools**: Network configuration and diagnostics
- **Update Manager**: System package updates and repository management

## Requirements

- Linux-based OS
- Bash 4.0+
- Core utilities: `tar`, `awk`, `ps`, `systemctl`
- Recommended tools:
  - `gum` (for TUI)
  - `fzf` (for fuzzy finding)
  - `neofetch`, `duf` (for system info)

## Installation

```bash
git clone https://github.com/yourusername/system-admin-toolkit.git
cd system-admin-toolkit
chmod +x *.sh
```

## Usage

Run the main menu:
```bash
./main.sh
```

### Script Overview

| Script | Description |
|--------|-------------|
| `Backup_utility.sh` | Create/restore compressed backups |
| `Process_managment.sh` | Process monitoring and control |
| `Service_managment.sh` | Service lifecycle management |
| `User_managment.sh` | User/group administration |
| `System_information.sh` | Real-time system monitoring |
| `Network_information.sh` | Network configuration tools |
| `System_Update.sh` | Package management |

## Examples

1. Create a backup:
```bash
./Backup_utility.sh
> Select "Backup"
> Enter directory path
> Name your backup
```

2. Monitor processes:
```bash
./Process_managment.sh
> View running processes
> Filter with fuzzy search
> Kill processes (with confirmation)
```

## Best Practices

1. **Backups**: Always test backup restoration
2. **Sudo**: Use regular user with sudo privileges
3. **Logging**: Check `./log/admin.log` for operations history

## Safety Features

- Confirmation prompts for destructive operations
- Input validation for critical commands
- Error logging for troubleshooting
- Password verification for user creation

## Roadmap

- [ ] Add plugin system for custom scripts
- [ ] Implement automated testing
- [ ] Add remote administration capabilities
- [ ] Develop web-based dashboard

## License

MIT License - See [LICENSE](LICENSE) for details.

## Contributing

Pull requests welcome! Please:
1. Maintain consistent style
2. Add error handling
3. Include documentation
4. Test changes thoroughly

---

