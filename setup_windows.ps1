Write-Host "Setting up Windows Environment"

if (Get-Command "winget") {
    Write-Host "Winget is installed"
} else {
    Start-Process "ms-windows-store://pdp?hl=en-us&gl=us&productid=9nblggh4nns1"
    Write-Host "Winget is not installed. Please install App Installer from the Microsoft Store."

    exit
}

Write-Host "Installing CMAke, Git, and PuTTY"

# Set execution policy to bypass for the current process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure TLS 1.2 is used for secure connections
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

if (Get-Command "cmake" -ErrorAction SilentlyContinue | Out-Null) {
    Write-Host "Cmake is already installed."
} else {
    winget install -e --id Kitware.CMake
}

if (Get-Command "git" -ErrorAction SilentlyContinue | Out-Null) {
    Write-Host "Git is already installed."
} else {
    winget install -e --id Git.Git
}

if (Get-Command "putty" -ErrorAction SilentlyContinue | Out-Null) {
    Write-Host "Putty is already installed."
} else {
    winget install -e --id PuTTY.PuTTY
}

if (Get-Command "clang-format" -ErrorAction SilentlyContinue | Out-Null) {
    Write-Host "Clang already installed"
} else {
    winget install -e --id LLVM.LLVM -v 15.0.7
}

if (-not (Test-Path "C:\EVT") ) {
    New-Item -ItemType Directory -Path C:\EVT
}

$ProgressPreference = 'SilentlyContinue'
if (-not (Test-Path "C:\EVT\arm-tools")) {
    Write-Host "Installing GNU ARM Embedded Toolchain"
    Invoke-WebRequest -uri "https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-mingw-w64-i686-arm-none-eabi.zip?rev=e6948d78806d4815912a858a6f6a85f6&hash=B20A83F31B9938D5EF819B14924A67E3" -Method "GET"  -Outfile "arm-tools.zip"

    Write-Host "Expanding ARM Tools, Errors are expected here..."
    Expand-Archive -Path "arm-tools.zip" -DestinationPath "arm-tools"
    Write-Host "Done Expanding ARM Tools."

    Move-Item -Path "arm-tools\arm-gnu-toolchain-12.3.rel1-mingw-w64-i686-arm-none-eabi" -Destination "C:\EVT\arm-tools"
    Remove-Item -Path "arm-tools"
    Remove-Item -Path "arm-tools.zip"
} else {
    Write-Host "GNU ARM Embedded Toolchain already installed."
}

if (-not (Test-Path "C:\EVT\openocd")) {
    Write-Host "Instlling OpenOCD"

    Invoke-WebRequest -uri "https://github.com/xpack-dev-tools/openocd-xpack/releases/download/v0.12.0-4/xpack-openocd-0.12.0-4-win32-x64.zip" -Method "GET"  -Outfile "openocd.zip"


    Write-Host "Expanding OpenOCD, Errors are expected here..."
    Expand-Archive -Path "openocd.zip" -DestinationPath "openocd"
    Write-Host "Done Expanding OpenOCD."

    Get-ChildItem -Path "openocd\xpack-openocd-0.12.0-4\openocd" -Directory | Move-Item -Destination ".\openocd\xpack-openocd-0.12.0-4"
    Remove-Item -Path "openocd\xpack-openocd-0.12.0-4\openocd"

    Move-Item -Path "openocd\xpack-openocd-0.12.0-4" -Destination "C:\EVT\openocd"
    Remove-Item "openocd"
    Remove-Item -Path "openocd.zip"
} else {
    Write-Host "OpenOCD already installed."
}

$ProgressPreference = 'Continue'

Write-Host "=== INSTALL LOCATIONS ==="
Write-Host "OpenOCD Install Location: C:\EVT\openocd\bin\openocd.exe"
Write-Host "ARM Tools Install Location: C:\EVT\arm-tools\bin"

Write-Host "=== Restart Computer ==="
Write-Host "Please restart your computer to complete the installation of all packages :)"
