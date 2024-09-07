import subprocess

def is_chocolately_installed():
    try:
        subprocess.run(["Get-Command", " -Name",  "choco.exe"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError:
        return False
    except FileNotFoundError:
        return False

def install_chocolately():
    install_command = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    subprocess.run(install_command, shell=True, check=True)
