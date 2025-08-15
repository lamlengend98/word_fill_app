@echo off
setlocal enabledelayedexpansion

echo ==========================================
echo Flutter Windows Installation Script
echo ==========================================
echo.

REM Check if running as Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Warning: This script is not running as Administrator.
    echo Some installations may require elevated privileges.
    echo.
)

REM Set variables
set "FLUTTER_VERSION=stable"
set "INSTALL_PATH=C:\flutter"
set "TEMP_DIR=%TEMP%"

echo Step 1: Installing Chocolatey...
where choco >nul 2>&1
if %errorLevel% neq 0 (
    echo Installing Chocolatey package manager...
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    
    REM Refresh PATH
    call refreshenv
    
    where choco >nul 2>&1
    if %errorLevel% equ 0 (
        echo Chocolatey installed successfully!
    ) else (
        echo Chocolatey installation failed. Please install manually.
        echo Visit: https://chocolatey.org/install
    )
) else (
    echo Chocolatey is already installed.
)
echo.

echo Step 2: Installing Git...
where git >nul 2>&1
if %errorLevel% neq 0 (
    if exist "C:\ProgramData\chocolatey\bin\choco.exe" (
        echo Installing Git via Chocolatey...
        choco install git -y
    ) else (
        echo Installing Git manually...
        powershell -Command "Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe' -OutFile '%TEMP%\Git-2.44.0-64-bit.exe'"
        if exist "%TEMP%\Git-2.44.0-64-bit.exe" (
            echo Running Git installer...
            "%TEMP%\Git-2.44.0-64-bit.exe" /VERYSILENT /NORESTART
            del "%TEMP%\Git-2.44.0-64-bit.exe"
        )
    )
    
    REM Refresh PATH
    call refreshenv
    
    where git >nul 2>&1
    if %errorLevel% equ 0 (
        echo Git installed successfully!
    ) else (
        echo Git installation failed. Please install manually.
        echo Visit: https://git-scm.com/download/win
    )
) else (
    echo Git is already installed.
)
echo.

echo Step 3: Installing Visual Studio Build Tools...
if not exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vs_installer.exe" (
    echo Downloading Visual Studio Build Tools...
    powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vs_buildtools.exe' -OutFile '%TEMP%\vs_buildtools.exe'"
    
    if exist "%TEMP%\vs_buildtools.exe" (
        echo Installing Visual Studio Build Tools...
        echo This may take several minutes. Please wait...
        "%TEMP%\vs_buildtools.exe" --quiet --wait --norestart --nocache --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.Windows10SDK.19041
        del "%TEMP%\vs_buildtools.exe"
        echo Visual Studio Build Tools installed successfully!
    ) else (
        echo Failed to download Visual Studio Build Tools.
        echo Please install manually from: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
    )
) else (
    echo Visual Studio Build Tools are already installed.
)
echo.

echo Step 4: Installing Flutter...
where flutter >nul 2>&1
if %errorLevel% neq 0 (
    echo Downloading Flutter SDK...
    
    REM Create installation directory
    if not exist "%INSTALL_PATH%" mkdir "%INSTALL_PATH%"
    
    REM Download Flutter
    powershell -Command "Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/%FLUTTER_VERSION%/windows/flutter_windows_%FLUTTER_VERSION%-stable.zip' -OutFile '%TEMP%\flutter_windows.zip'"
    
    if exist "%TEMP%\flutter_windows.zip" (
        echo Extracting Flutter SDK...
        powershell -Command "Expand-Archive -Path '%TEMP%\flutter_windows.zip' -DestinationPath '%INSTALL_PATH%' -Force"
        del "%TEMP%\flutter_windows.zip"
        
        REM Add Flutter to PATH
        echo Adding Flutter to PATH...
        setx PATH "%PATH%;%INSTALL_PATH%\bin"
        
        echo Flutter installed successfully!
    ) else (
        echo Failed to download Flutter SDK.
        echo Please install manually from: https://flutter.dev/docs/get-started/install/windows
    )
) else (
    echo Flutter is already installed.
)
echo.

echo Step 5: Installing Android Studio...
if not exist "%ProgramFiles%\Android\Android Studio\bin\studio64.exe" (
    echo Downloading Android Studio...
    powershell -Command "Invoke-WebRequest -Uri 'https://redirector.gvt1.com/edgedl/android/studio/install/2023.1.1.26/android-studio-2023.1.1.26-windows.exe' -OutFile '%TEMP%\android-studio-installer.exe'"
    
    if exist "%TEMP%\android-studio-installer.exe" (
        echo Installing Android Studio...
        echo This may take several minutes. Please wait...
        "%TEMP%\android-studio-installer.exe" /S
        del "%TEMP%\android-studio-installer.exe"
        echo Android Studio installed successfully!
        echo Please launch Android Studio and complete the setup wizard.
    ) else (
        echo Failed to download Android Studio.
        echo Please install manually from: https://developer.android.com/studio
    )
) else (
    echo Android Studio is already installed.
)
echo.

echo Step 6: Verifying Flutter installation...
where flutter >nul 2>&1
if %errorLevel% equ 0 (
    echo Running flutter doctor...
    flutter doctor
    
    echo.
    echo ==========================================
    echo Installation Complete!
    echo ==========================================
    echo.
    echo Next steps:
    echo 1. Restart your terminal/command prompt
    echo 2. Run 'flutter doctor' to check for any remaining issues
    echo 3. If you installed Android Studio, launch it and complete the setup
    echo 4. Accept Android licenses: flutter doctor --android-licenses
    echo.
    echo Flutter is now ready for Windows development!
) else (
    echo Flutter installation verification failed.
    echo Please restart your terminal and try running 'flutter doctor'
)

echo.
pause
