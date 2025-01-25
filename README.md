# RIT-EVT Setup Script
This repository contains a single file with the purpose of setting up an EVT Development Enivornment for team members. This script was created to streamline the process of installing complex components of the EVT environment.

Installation has been streamlined to a single command on both macOS, Windows and Linux.

# Installation
## Installing for macOS
Paste this command into macOS terminal.
```bash
curl https://raw.githubusercontent.com/RIT-EVT/Setup-Script/main/setup_mac.sh | sh
```

## Installing for Linux
Paste this command into any linux terminal.
```bash
curl https://raw.githubusercontent.com/RIT-EVT/Setup-Script/main/setup_linux.sh | bash
```

## Installing for Windows
Paste this command into a powershell window.
```powershell
irm "https://raw.githubusercontent.com/RIT-EVT/Setup-Script/main/setup_windows.ps1" | iex
```

# Components
1. CMake
2. GNU Arm Tools
3. OpenOCD
4. Git (Windows Only)
5. PuTTy (Windows Only)
6. Homebrew (Mac Only)
7. clang-format (Mac Only)
