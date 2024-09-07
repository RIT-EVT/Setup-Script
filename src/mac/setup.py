from mac.package_manager import is_homebrew_installed, install_homebrew
from mac.packages import install_packages
from mac.path import update_shell

def setup():
    print("Checking Package Manager...")

    if is_homebrew_installed():
        print("Homebrew already installed!")
    else:
        print("Installing Homebrew...")
        installed_succesfully = install_homebrew()
        if installed_succesfully:
            print("Homebrew installed successfully!")
        else:
            print("Homebrew installation failed. Please install Homebrew manually at https://brew.sh/.")
            raise Exception("Homebrew installation failed.")

    print("Package manager succesfully installed!")
    print("The setup script will now install the necessary packages for the RIT EVT project.")

    print("Installing macOS packages...")
    install_packages()

    print("Updating macOS Path")
    update_shell()
