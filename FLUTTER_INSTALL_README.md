# Flutter Windows Installation Scripts

This package contains automated scripts to install Flutter and all its dependencies on Windows machines.

## 📦 **What Gets Installed**

### **Core Components:**
- ✅ **Flutter SDK** (latest stable version)
- ✅ **Git** (version control)
- ✅ **Visual Studio Build Tools** (C++ compilation)
- ✅ **Chocolatey** (package manager)
- ✅ **Android Studio** (optional, for Android development)

### **Features:**
- 🔄 **Automatic dependency detection** - Skips already installed components
- 🛡️ **Error handling** - Graceful fallbacks for failed installations
- 🎨 **Colored output** - Easy to follow progress indicators
- ⚙️ **Configurable** - Customizable installation paths and options
- 🔧 **PATH management** - Automatically adds Flutter to system PATH

## 🚀 **Quick Start**

### **Option 1: PowerShell (Recommended)**
```powershell
# Right-click install_flutter_windows.ps1 and "Run with PowerShell"
# OR run from PowerShell:
.\install_flutter_windows.ps1
```

### **Option 2: Command Prompt**
```cmd
# Double-click install_flutter_windows.bat
# OR run from Command Prompt:
install_flutter_windows.bat
```

## ⚙️ **Advanced Usage**

### **PowerShell Script Options**
```powershell
# Install with custom Flutter version
.\install_flutter_windows.ps1 -FlutterVersion "beta"

# Install to custom directory
.\install_flutter_windows.ps1 -InstallPath "D:\flutter"

# Skip specific components
.\install_flutter_windows.ps1 -SkipAndroidStudio -SkipVSBuildTools

# Install only Flutter (skip other tools)
.\install_flutter_windows.ps1 -SkipChocolatey -SkipGit -SkipVSBuildTools -SkipAndroidStudio
```

### **Available Parameters:**
- `-FlutterVersion`: Flutter version to install (stable, beta, master)
- `-InstallPath`: Custom installation path (default: C:\flutter)
- `-SkipChocolatey`: Skip Chocolatey installation
- `-SkipGit`: Skip Git installation
- `-SkipVSBuildTools`: Skip Visual Studio Build Tools
- `-SkipAndroidStudio`: Skip Android Studio installation

## 📋 **Installation Steps**

The script performs these steps automatically:

### **Step 1: Chocolatey Package Manager**
- Installs Chocolatey for easy package management
- Used for installing Git and other tools

### **Step 2: Git**
- Installs Git for version control
- Required for Flutter development

### **Step 3: Visual Studio Build Tools**
- Installs C++ build tools
- Required for Windows desktop development
- Includes Windows 10 SDK

### **Step 4: Flutter SDK**
- Downloads latest stable Flutter
- Extracts to specified directory
- Adds to system PATH

### **Step 5: Android Studio (Optional)**
- Installs Android Studio
- Required for Android development
- Can be skipped with `-SkipAndroidStudio`

### **Step 6: Verification**
- Runs `flutter doctor`
- Shows installation status
- Provides next steps

## 🔧 **System Requirements**

### **Minimum Requirements:**
- Windows 10 or later (64-bit)
- 8 GB RAM (16 GB recommended)
- 10 GB free disk space
- Internet connection

### **Recommended:**
- Windows 11
- 16 GB RAM
- 20 GB free disk space
- SSD storage

## 🛠️ **Troubleshooting**

### **Common Issues:**

#### **1. PowerShell Execution Policy**
```powershell
# If you get execution policy errors:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### **2. Administrator Privileges**
- Some installations require Administrator rights
- Right-click PowerShell/Command Prompt and "Run as Administrator"

#### **3. Network Issues**
- Check your internet connection
- Disable antivirus temporarily if downloads fail
- Use VPN if behind corporate firewall

#### **4. PATH Issues**
```cmd
# Refresh environment variables
refreshenv
# OR restart your terminal
```

#### **5. Visual Studio Build Tools**
- If installation fails, download manually from Microsoft
- Make sure to include "Desktop development with C++" workload

### **Manual Installation Links:**
- **Flutter**: https://flutter.dev/docs/get-started/install/windows
- **Git**: https://git-scm.com/download/win
- **Visual Studio Build Tools**: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
- **Android Studio**: https://developer.android.com/studio
- **Chocolatey**: https://chocolatey.org/install

## ✅ **Verification**

After installation, verify everything works:

```bash
# Check Flutter installation
flutter doctor

# Check specific components
flutter doctor --android-licenses
flutter config --list

# Test Windows build
flutter build windows --release
```

## 📁 **File Structure**

```
word_filler_app/
├── install_flutter_windows.ps1      # PowerShell installation script
├── install_flutter_windows.bat      # Command Prompt installation script
├── build_windows.ps1                # Windows build script
├── build_windows.bat                # Windows build script (CMD)
├── FLUTTER_INSTALL_README.md        # This file
└── WINDOWS_BUILD_README.md          # Windows build instructions
```

## 🎯 **Next Steps**

After successful installation:

1. **Restart your terminal** to refresh environment variables
2. **Run `flutter doctor`** to check for any remaining issues
3. **Accept Android licenses**: `flutter doctor --android-licenses`
4. **Build your app**: Use the provided build scripts
5. **Start developing**: Your Flutter environment is ready!

## 🆘 **Support**

If you encounter issues:

1. **Check the troubleshooting section** above
2. **Run `flutter doctor`** to identify specific problems
3. **Check Flutter documentation**: https://flutter.dev/docs
4. **Review installation logs** for error messages

## 📝 **Notes**

- The script automatically handles PATH environment variables
- All downloads are saved to temporary directory and cleaned up
- Installation can take 15-30 minutes depending on internet speed
- Some components may require system restart to take effect
- Android Studio setup wizard must be completed manually after installation
