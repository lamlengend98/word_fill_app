# Windows Build Instructions for Word Filler App

## Prerequisites

### 1. Install Flutter on Windows
1. Download Flutter SDK from: https://flutter.dev/docs/get-started/install/windows
2. Extract to a folder (e.g., `C:\flutter`)
3. Add Flutter to your PATH environment variable
4. Run `flutter doctor` to verify installation

### 2. Install Visual Studio Build Tools
1. Download Visual Studio Build Tools from: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
2. Install with "Desktop development with C++" workload
3. Make sure Windows 10 SDK is included

### 3. Install Git
1. Download Git from: https://git-scm.com/download/win
2. Install with default settings

## Building the Windows Executable

### Option 1: Using the Build Scripts (Recommended)

#### Using PowerShell (Recommended)
```powershell
# Right-click on build_windows.ps1 and select "Run with PowerShell"
# OR run from PowerShell:
.\build_windows.ps1
```

#### Using Command Prompt
```cmd
# Double-click build_windows.bat
# OR run from Command Prompt:
build_windows.bat
```

### Option 2: Manual Build

1. **Open Command Prompt or PowerShell** in the project directory

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Build Windows executable:**
   ```bash
   flutter build windows --release
   ```

4. **Find the executable:**
   - Main executable: `build\windows\runner\Release\word_filler_app.exe`
   - Complete app folder: `build\windows\runner\Release\`

## Distribution Options

### Option 1: Single Executable
- Copy `word_filler_app.exe` to any Windows machine
- Note: This requires the user to have Visual C++ Redistributable installed

### Option 2: Portable Folder (Recommended)
- Copy the entire `Release` folder
- Users can run the app by double-clicking `word_filler_app.exe` in the folder
- No installation required

### Option 3: Create Installer
- Use tools like Inno Setup or NSIS to create a Windows installer
- Include Visual C++ Redistributable in the installer

## Troubleshooting

### Common Issues

1. **"flutter command not found"**
   - Make sure Flutter is in your PATH
   - Restart Command Prompt/PowerShell after adding to PATH

2. **"Visual Studio Build Tools not found"**
   - Install Visual Studio Build Tools with C++ workload
   - Make sure Windows 10 SDK is included

3. **"CMake not found"**
   - Install CMake from: https://cmake.org/download/
   - Add CMake to PATH

4. **Build fails with C++ errors**
   - Make sure you have the latest Visual Studio Build Tools
   - Try running `flutter clean` before building

### Verification Commands

```bash
# Check Flutter installation
flutter doctor

# Check Windows build support
flutter config --list

# Clean build cache if needed
flutter clean

# Get dependencies
flutter pub get

# Build again
flutter build windows --release
```

## File Structure After Build

```
build/windows/runner/Release/
├── word_filler_app.exe          # Main executable
├── data/                        # App data and assets
├── *.dll                        # Required DLL files
└── [other supporting files]
```

## Features Included

✅ Business sector management with edit functionality  
✅ Information copying between different roles  
✅ Word document generation  
✅ All form fields and validation  
✅ Professional UI with proper styling  
✅ Cross-platform compatibility  

## Support

If you encounter any issues during the build process, please check:
1. Flutter installation: `flutter doctor`
2. Windows build tools installation
3. Project dependencies: `flutter pub get`
4. Build logs for specific error messages
