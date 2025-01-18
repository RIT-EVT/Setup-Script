# RIT-EVT Setup Script
This repository contains a single file with the purpose of setting up an EVT Development Enivornment for team members. This script was created to streamline the process of installing complex components of the EVT environment.

Installation has been streamlined to a single command on both macOS and Windows.

# Installation
## Installing for macOS
```bash
curl https://raw.githubusercontent.com/RIT-EVT/Setup-Script/main/setup.sh | sh
```

## Installing for Windows
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
