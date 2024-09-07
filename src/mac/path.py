import os

bash_zsh_path ="""
export GCC_ARM_TOOLS_PATH="$HOMEBREW_PREFIX/bin/"
export PATH=$PATH:/Applications/CMake.app/Contents/bin
"""
fish_path="""
set PATH $PATH /Applications/CMake.app/Contents/bin
set -x GCC_ARM_TOOLS_PATH '$HOMEBREW_PREFIX/bin/'
"""

def update_zsh():
    zshrc_path = os.path.expanduser('~/.zshrc')
    with open(zshrc_path, 'r') as f:
        existing_content = f.read()

    if bash_zsh_path not in existing_content:
        with open(zshrc_path, 'a') as f:
            f.write(bash_zsh_path)
        print("Added export statements to .zshrc")
    else:
        print("Export statements already exist in .zshrc")

def update_bash():
    bash_profile_path = os.path.expanduser('~/.bash_profile')
    with open(bash_profile_path, 'r') as f:
        existing_content = f.read()

    if bash_zsh_path not in existing_content:
        with open(bash_profile_path, 'a') as f:
            f.write(bash_zsh_path)
        print("Added export statements to .bash_profile")
    else:
        print("Export statements already exist in .bash_profile")

def update_fish():
    fish_config_path = os.path.expanduser('~/.config/fish/config.fish')
    with open(fish_config_path, 'r') as f:
        existing_content = f.read()

    if fish_path not in existing_content:
        with open(fish_config_path, 'a') as f:
            f.write(fish_path)
        print("Added export statements to config.fish")
    else:
        print("Export statements already exist in config.fish")

def update_shell():
    user_shell = os.environ.get('SHELL', '')

    if '/zsh' in user_shell:
        print("Detected Zsh shell")
        update_zsh()
    elif '/bash' in user_shell:
        print("Detected Bash shell")
        update_bash()
    elif '/fish' in user_shell:
        print("Detected Fish shell")
        update_fish()
    else:
        raise ValueError(f"Detected unknown shell: {user_shell}")
