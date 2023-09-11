#!/bin/sh
# This set's up an EVT Development Environment from scratch for a macOS System.

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not installed... Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed, updating"
    brew update
fi

# Get the brew tap that hosts all of the brew files we need
brew tap actuallytaylor/formulae

# Install the GNU ARM TOOLCHAIN
brew install arm-gnu-toolchain@12.rb


# Export the environment variable into the PATH based on the SHELL
if [[ $SHELL == "/bin/zsh" ]]; then
    echo 'export GCC_ARM_TOOLS_PATH="/usr/local/bin"' >> ~/.zshrc
    source ~/.zshrc
elif [[ $SHELL == "/bin/sh" ]]; then
    echo 'export GCC_ARM_TOOLS_PATH="/usr/local/bin"' >> ~/.bash_profile
    source ~/.bash_profile
fi

# Install CMAKE
brew install --cask cmake

# Install clang-format
brew install clang-format
