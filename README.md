# RIT-EVT Setup Script
This repository contains setup scripts for an EVT Development Enivornment. This script was created to streamline the process of installing complex components of the EVT environment.

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
4. clang-format
5. Git (Windows Only)
6. PuTTy (Windows Only)
7. Homebrew (Mac Only)
