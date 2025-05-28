# 🖥️ System Admin Dashboard

A lightweight, terminal-based system administration dashboard for Linux systems. Built with shell scripts and powered by tools like `fzf`, `neofetch`, and `duf`, this project provides an intuitive, menu-driven interface for monitoring your system and managing users—all from the terminal.

---

## 🚀 Features

- 🔧 **Modular Dashboard Interface** — Navigate options with `fzf` and execute system utilities effortlessly.
- 👤 **User Management** — Add, remove, and view system users using the custom `gomu` module.
- 📊 **System Info Summary** — Display system stats like CPU usage, memory, disk info, and more using `neofetch`, `duf`, and `free`.
- 📁 **Modular Architecture** — Easy to extend with your own tools and scripts.

---

## 📂 Project Structure

```bash
System-Admin-Dashboard/
├── admin_dashboard.sh      # Launches the dashboard with elevated permissions
├── main.sh                 # Core menu logic using fzf
├── install.sh              # Setup script to prepare your environment
├── version.json            # Versioning info
├── modules/                # Dashboard feature modules (e.g. user management)
├── lib/                    # Reusable helper functions
├── neofetch/               # Neofetch configurations
├── utilis/                 # Utility scripts and components
└── human_users.txt         # List or log of system users
````

---

## 🛠️ Requirements

Make sure the following tools are installed:

* `bash` (v4+)
* [`fzf`](https://github.com/junegunn/fzf)
* [`neofetch`](https://github.com/dylanaraps/neofetch)
* [`duf`](https://github.com/muesli/duf)
* `sudo`

To install on Ubuntu/Debian:

```bash
sudo apt update
sudo apt install fzf neofetch
```

Install `duf` from [GitHub Releases](https://github.com/muesli/duf/releases) or your package manager.

---

## 📥 Installation

```bash
git clone https://github.com/AtomicPositron/System-Admin-Dashboard.git
cd System-Admin-Dashboard
chmod +x install.sh
./install.sh
```

---

## 🧑‍💻 Usage

Launch the dashboard with admin privileges:

```bash
chmod +x admin_dashboard.sh
./admin_dashboard.sh
```

Or directly use:

```bash
chmod +x main.sh
./main.sh
```

---

## 🔌 Extending the Dashboard

Add new modules to the `modules/` directory. Each module should be a bash script with a standard function interface so it integrates seamlessly with the dashboard menu system.

---

## 📜 License

MIT License — feel free to modify and redistribute.

---

## ✍️ Author

**Marshall (AtomicPositron)**
GitHub: [github.com/AtomicPositron](https://github.com/AtomicPositron)

---

## ⭐️ Contributions

Feedback, issues, and pull requests are welcome!

```

---

Let me know if you'd like me to format and push this to your repo or if you want specific icons or badges included.
```
