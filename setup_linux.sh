#!/bin/bash

# This sets up an EVT Development Environment from scratch for a Linux System.
bold=$(tput bold)
normal=$(tput sgr0)

echo "========================================================="
echo "${bold}This script will set up all of the required packages and environment vairables that are used by an RIT-EVT Firmware developer.${normal}"
echo "1. This script will create an EVT directory for you."
echo "2. The ARM GNU Toolchain will be installed. Either the aarch64 or amd64 version depending on your system."
echo "3. EVT's custom variable (GCC_ARM_TOOLS_PATH) will be added to your path."
echo "4. cmake will be installed if it is not available using your default package manager."
echo "========================================================="
echo ""
echo "${bold}Creating a default directory ~/.EVT${normal}"

arch=$(uname -m)
install_dir=~/.EVT

mkdir -p $install_dir
mkdir -p $install_dir/arm_tools

if [[ $arch == "aarch64" ]]; then
  # We are on an ARM device
  gcc_tools_download_link="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-aarch64-arm-none-eabi.tar.xz"
else
  # We are on an x86_64 Device
  gcc_tools_download_link="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz"
fi

if [ ! -d "$install_dir/arm_tools/bin" ]; then
    echo "${bold}Installing ARM toolchain${normal}"

    installed=0

    if command -v curl >/dev/null 2>&1; then
        # Curl is installed
        curl -o arm_tools.tar.xz $gcc_tools_download_link
        tar -xvf arm_tools.tar.xz -C $install_dir/arm_tools --strip-components 1
        rm arm_tools.tar.xz
        installed=1
    fi

    if command -v wget >/dev/null 2>&1; then
        # Wget is installed
        wget -O arm_tools.tar.xz $gcc_tools_download_link
        tar -xvf arm_tools.tar.xz -C $install_dir/arm_tools --strip-components 1
        rm arm_tools.tar.xz
        installed=1
    fi

    if [ $installed -eq 0 ]; then
        echo "Error: Neither curl nor wget is installed. Please install one of them."
        exit 1
    fi

    echo "${bold}Setting GCC_ARM_TOOLS_PATH${normal}"
    if [[ $SHELL = "/bin/zsh" ]]; then
        echo "You may receieve a warning on the next command, that is expected and okay."
        echo 'export GCC_ARM_TOOLS_PATH="${HOME}/.EVT/arm_tools/bin"' >> ~/.zshrc
        source ~/.zshrc
    elif [[ $SHELL == "/bin/bash" ]]; then
        echo 'export GCC_ARM_TOOLS_PATH="${HOME}/.EVT/arm_tools/bin"' >> ~/.bash_profile
        echo 'export GCC_ARM_TOOLS_PATH="${HOME}/.EVT/arm_tools/bin"' >> ~/.bashrc
        source ~/.bash_profile
    elif [[ $SHELL == "/bin/fish" ]]; then
        echo 'set -gx GCC_ARM_TOOLS_PATH ${HOME}.EVT/arm_tools/bin' >> ~/.config/fish/config.fish
        source ~/.config/fish/config.fish
    else
        echo 'Shell, not recognized. Please add export GCC_ARM_TOOLS_PATH="~/.EVT/arm_tools/bin to your shell config file.'
    fi
else
    echo "${bold}ARM toolchain already installed${normal}"
fi

echo "${bold}Installing CMAKE${normal}"

if ! command -v cmake >/dev/null 2>&1; then
  if command -v apt >/dev/null 2>&1; then
      echo "Installing using apt..."
      if [[ $EUID -ne 0 ]]; then
          sudo apt install cmake
      else
          apt install cmake
      fi
  elif command -v pacman >/dev/null 2>&1; then
      echo "Installing using pacman..."
      if [[ $EUID -ne 0 ]]; then
          sudo pacman -Syu cmake
      else
          pacman -Syu cmake
      fi
  else
      echo "Could not identify the package manager. Please manually install CMAKE."
      exit 0
  fi
else
    echo "cmake has been detected as already installed."
fi

if ! command -v clang-format --version >/dev/null 2>&1; then
  if command -v apt >/dev/null 2>&1; then
      echo "Installing using apt..."
      if [[ $EUID -ne 0 ]]; then
          sudo apt install clang-format
      else
          apt install clang-format
      fi
  elif command -v pacman >/dev/null 2>&1; then
      echo "Installing using pacman..."
      if [[ $EUID -ne 0 ]]; then
          sudo pacman -Syu clang
      else
          pacman -Syu clang
      fi

  else
      echo "Could not identify the package manager. Please manually install LLVM / Clang Tools."
      exit 0
  fi
else
    echo "clang-format has been detected as already installed."
fi

echo "${bold}Finished installing an EVT environment to your computer.${normal}"
