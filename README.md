# RIT-EVT Setup Script
This repository contains a single file with the purpose of setting up an EVT Development Enivornment for a macOS developer. This script was created to streamline the process of installing the basic environment setup for members of the team using macOS.

## Installing
There are three commands needed to download and run the setup script. These commands will work on a blank install of macOS so you should not have any provlems running them.

```
curl -o setup.sh https://raw.githubusercontent.com/ActuallyTaylor/RIT-EVT-Setup/main/setup.sh
chmod 755 setup.sh
./setup.sh
```

## Notes
This script has been tested on multiple macOS virtual machines, my personal machine and a few members of EVT's machines. It is not perfect but should work for both Apple Silicon, Apple Silicon in Rosetta, and Intel Macs. If you have any issues feel free to edit the script and submit a pull request.
