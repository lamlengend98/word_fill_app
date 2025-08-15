@echo off
echo Building Word Filler App for Windows...
echo.

REM Check if Flutter is installed
flutter --version >nul 2>&1
if errorlevel 1 (
    echo Error: Flutter is not installed or not in PATH
    echo Please install Flutter from https://flutter.dev/docs/get-started/install/windows
    pause
    exit /b 1
)

echo Flutter found. Getting dependencies...
flutter pub get

echo.
echo Building Windows executable...
flutter build windows --release

if errorlevel 1 (
    echo.
    echo Build failed! Please check the error messages above.
    pause
    exit /b 1
)

echo.
echo Build successful!
echo.
echo The Windows executable is located at:
echo build\windows\runner\Release\word_filler_app.exe
echo.
echo You can also find the complete application folder at:
echo build\windows\runner\Release\
echo.
echo To create a portable version, copy the entire Release folder.
echo.
pause
