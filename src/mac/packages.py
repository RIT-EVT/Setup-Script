import subprocess

def install_packages():
    subprocess.run(["brew", "bundle", "install"], check=True)
