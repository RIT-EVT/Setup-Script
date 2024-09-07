from mac.setup import setup as macos_setup
from windows.setup import setup as windows_setup
import platform

print("Welcome to the RIT EVT setup script.")
print("This script was written to support Windows, macOS, and Linux.")

system: str = platform.system()

if system == "Windows":
    print("Detected Windows system.")
    windows_setup()
elif system == "Darwin":
    print("Detected macOS system.")
    try:
        macos_setup()
    except Exception as e:
        print(f"macOS setup failed: {e}. You will need to install the necessary packages manually.")

print("Setup complete.")
