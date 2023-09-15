#!/bin/sh
# This sets up an EVT Development Environment from scratch for a macOS System.
bold=$(tput bold)
normal=$(tput sgr0)

echo "========================================================="
echo "${bold}This script will set up all of the required packages and environment vairables that are used by an RIT-EVT Firmware developer.${normal}"
echo "1. The script will check to see if you have brew installed (https://brew.sh)"
echo "2. If you do not have brew installed, the script will install brew for you."
echo "3. The arm-gnu-toolchain version 12.3 will be installed. An Apple-Silicon or Intel version will be installed depending on your system."
echo "4. EVT's custom path variable GCC_ARM_TOOLS_PATH will be added to your terminal's path."
echo "5. CMAKE will be installed using brew and then added to your PATH."
echo "6. clang-format will be installed using brew."
echo "7. That's it! Everything should be set up now."
echo "========================================================="
echo ""


read -p "${bold}Do you want to continue with installing this script? (y or n)${normal}" -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo "${bold}Script exiting now... Goodbye!${normal}"
    exit
fi

echo ""
echo "========================================================="
echp ""
echo "${bold}Checking for the existence of Homebrew. If it does not exist, it will be installed${normal}"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not installed... Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Initialize a homebrew location based on the architecture of the machine.
    MACHINE_ARCHITECTURE="$(/usr/bin/uname -m)"

    if [[ $SHELL = "/bin/zsh" ]]; then
        if [[ "${MACHINE_ARCHITECTURE}" == "arm64" ]]; then
            # On ARM macOS, homebrew is installed into /opt/homebrew
            echo; (echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
            source ~/.zprofile

            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            # On Intel macOS, homebrew is installed into /usr/local
            echo; (echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile
            source ~/.zprofile

            eval "$(/usr/local/bin/brew shellenv)"
        fi
        source ~/.zprofile
    elif [[ $SHELL = "/bin/bash" ]]; then
        if [[ "${MACHINE_ARCHITECTURE}" == "arm64" ]]; then
            # On ARM macOS, homebrew is installed into /opt/homebrew
            echo; (echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.profile
            source ~/.profile

            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            # On Intel macOS, homebrew is installed into /usr/local
            echo; (echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.profile
            source ~/.profile
            
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
else
    echo "${bold}Homebrew already installed, updating${normal}"
    brew update
fi

# Get the brew tap that hosts all of the brew files we need
echo "${bold}Tapping the homebrew tap that contains the ARM Toolchain${normal}"
brew tap actuallytaylor/formulae

# Install the GNU ARM TOOLCHAIN
echo "${bold}Installing the arm toolchain${normal}"
brew install arm-gnu-toolchain@12

echo "${bold}Adding GCC_ARM_TOOLS_PATH to your shell PATH variables...${normal}"
# Export the environment variable into the PATH based on the SHELL
if [[ $SHELL = "/bin/zsh" ]]; then
    echo "You may receieve a warning on the next command, that is expected and okay."
    echo 'export GCC_ARM_TOOLS_PATH="$HOMEBREW_PREFIX/bin/"' >> ~/.zshrc
    source ~/.zshrc
elif [[ $SHELL = "/bin/bash" ]]; then
    echo 'export GCC_ARM_TOOLS_PATH="$HOMEBREW_PREFIX/bin/"' >> ~/.bash_profile
    source ~/.bash_profile
else
    echo 'Shell, not recognized. Please add export GCC_ARM_TOOLS_PATH="$HOMEBREW_PREFIX/bin to your shell config file.'
fi

# Install CMAKE
echo "${bold}Installing CMAKE${normal}"
brew install --cask cmake

if [[ $SHELL = "/bin/zsh" ]]; then
    echo "export PATH=\$PATH:/Applications/CMake.app/Contents/bin" >> ~/.zshrc
    source ~/.zshrc
elif [[ $SHELL = "/bin/bash" ]]; then
    echo "export PATH=\$PATH:/Applications/CMake.app/Contents/bin" >> ~/.bash_profile
    source ~/.bash_profile
else
    echo 'Shell, not recognized. Please add export PATH=$PATH:/Applications/CMake.app/Contents/bin to your shell config file.'
fi

# Install clang-format
echo "${bold}Installing clang-format${normal}"
brew install clang-format

echo ""
echo "${bold}Finished installing an EVT environment to your computer.${normal}"
