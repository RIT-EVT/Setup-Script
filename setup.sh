#!/bin/sh
# This set's up an EVT Development Environment from scratch for a macOS System.

echo "Checking for the existence of Homebrew. If it does not exist, it will be installed"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not installed... Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $SHELL = "/bin/zsh" ]]; then
        echo; (echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    elif [[ $SHELL = "/bin/bash" ]]; then
        echo; (echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.profile
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed, updating"
    brew update
fi

# Get the brew tap that hosts all of the brew files we need
echo "Tapping the homebrew tap that contains the ARM Toolchain"
brew tap actuallytaylor/formulae

# Install the GNU ARM TOOLCHAIN
echo "Installing the arm toolchain"
brew install arm-gnu-toolchain@12.rb

echo "Adding GCC_ARM_TOOLS_PATH to your shell PATH variables..."
# Export the environment variable into the PATH based on the SHELL
if [[ $SHELL = "/bin/zsh" ]]; then
    echo "A warning or error from the next command is expected."
    echo '\nexport GCC_ARM_TOOLS_PATH="/usr/local/bin"' >> ~/.zshrc
    source ~/.zshrc
elif [[ $SHELL = "/bin/bash" ]]; then
    echo 'export GCC_ARM_TOOLS_PATH="/usr/local/bin"' >> ~/.bash_profile
    source ~/.bash_profile
else
    echo 'Shell $0, not recognized. Please add export GCC_ARM_TOOLS_PATH="/usr/local/bin to your shell config file.'
fi

echo "Installing CMAKE"
# Install CMAKE
brew install --cask cmake

echo "Installing clang-format"
# Install clang-format
brew install clang-format
