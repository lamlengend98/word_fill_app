# Flutter Windows Installation Script
# This script installs Flutter and all required dependencies for Windows development

param(
    [string]$FlutterVersion = "stable",
    [string]$InstallPath = "C:\flutter",
    [switch]$SkipChocolatey,
    [switch]$SkipGit,
    [switch]$SkipVSBuildTools,
    [switch]$SkipAndroidStudio
)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Flutter Windows Installation Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "Warning: This script is not running as Administrator." -ForegroundColor Yellow
    Write-Host "Some installations may require elevated privileges." -ForegroundColor Yellow
    Write-Host ""
}

# Function to check if command exists
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Function to download file
function Download-File($url, $output) {
    try {
        Write-Host "Downloading $url..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        return $true
    }
    catch {
        Write-Host "Failed to download $url" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        return $false
    }
}

# Function to extract ZIP file
function Expand-ZipFile($zipPath, $extractPath) {
    try {
        Write-Host "Extracting $zipPath to $extractPath..." -ForegroundColor Yellow
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
        return $true
    }
    catch {
        Write-Host "Failed to extract $zipPath" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        return $false
    }
}

# Step 1: Install Chocolatey (if not skipped)
if (-not $SkipChocolatey) {
    Write-Host "Step 1: Installing Chocolatey..." -ForegroundColor Green
    if (-not (Test-Command "choco")) {
        Write-Host "Installing Chocolatey package manager..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        if (Test-Command "choco") {
            Write-Host "Chocolatey installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Chocolatey installation failed. Please install manually." -ForegroundColor Red
            Write-Host "Visit: https://chocolatey.org/install" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Chocolatey is already installed." -ForegroundColor Green
    }
    Write-Host ""
}

# Step 2: Install Git (if not skipped)
if (-not $SkipGit) {
    Write-Host "Step 2: Installing Git..." -ForegroundColor Green
    if (-not (Test-Command "git")) {
        if (Test-Command "choco") {
            Write-Host "Installing Git via Chocolatey..." -ForegroundColor Yellow
            choco install git -y
        } else {
            Write-Host "Installing Git manually..." -ForegroundColor Yellow
            $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe"
            $gitInstaller = "$env:TEMP\Git-2.44.0-64-bit.exe"
            
            if (Download-File $gitUrl $gitInstaller) {
                Write-Host "Running Git installer..." -ForegroundColor Yellow
                Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
                Remove-Item $gitInstaller -Force
            }
        }
        
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        if (Test-Command "git") {
            Write-Host "Git installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Git installation failed. Please install manually." -ForegroundColor Red
            Write-Host "Visit: https://git-scm.com/download/win" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Git is already installed." -ForegroundColor Green
    }
    Write-Host ""
}

# Step 3: Install Visual Studio Build Tools (if not skipped)
if (-not $SkipVSBuildTools) {
    Write-Host "Step 3: Installing Visual Studio Build Tools..." -ForegroundColor Green
    $vsBuildToolsPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vs_installer.exe"
    
    if (-not (Test-Path $vsBuildToolsPath)) {
        Write-Host "Downloading Visual Studio Build Tools..." -ForegroundColor Yellow
        $vsBuildToolsUrl = "https://aka.ms/vs/17/release/vs_buildtools.exe"
        $vsBuildToolsInstaller = "$env:TEMP\vs_buildtools.exe"
        
        if (Download-File $vsBuildToolsUrl $vsBuildToolsInstaller) {
            Write-Host "Installing Visual Studio Build Tools..." -ForegroundColor Yellow
            Write-Host "This may take several minutes. Please wait..." -ForegroundColor Yellow
            
            $arguments = @(
                "--quiet",
                "--wait",
                "--norestart",
                "--nocache",
                "--installPath", "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2022\BuildTools",
                "--add", "Microsoft.VisualStudio.Workload.VCTools",
                "--add", "Microsoft.VisualStudio.Component.Windows10SDK.19041"
            )
            
            Start-Process -FilePath $vsBuildToolsInstaller -ArgumentList $arguments -Wait
            Remove-Item $vsBuildToolsInstaller -Force
            
            Write-Host "Visual Studio Build Tools installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Failed to download Visual Studio Build Tools." -ForegroundColor Red
            Write-Host "Please install manually from: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Visual Studio Build Tools are already installed." -ForegroundColor Green
    }
    Write-Host ""
}

# Step 4: Install Flutter
Write-Host "Step 4: Installing Flutter..." -ForegroundColor Green
if (Test-Command "flutter") {
    Write-Host "Flutter is already installed." -ForegroundColor Green
} else {
    Write-Host "Downloading Flutter SDK..." -ForegroundColor Yellow
    
    # Create installation directory
    if (-not (Test-Path $InstallPath)) {
        New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
    }
    
    # Download Flutter
    $flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/$FlutterVersion/windows/flutter_windows_$FlutterVersion-stable.zip"
    $flutterZip = "$env:TEMP\flutter_windows.zip"
    
    if (Download-File $flutterUrl $flutterZip) {
        Write-Host "Extracting Flutter SDK..." -ForegroundColor Yellow
        if (Expand-ZipFile $flutterZip $InstallPath) {
            Remove-Item $flutterZip -Force
            
            # Add Flutter to PATH
            Write-Host "Adding Flutter to PATH..." -ForegroundColor Yellow
            $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
            if ($currentPath -notlike "*$InstallPath\bin*") {
                [Environment]::SetEnvironmentVariable("Path", "$currentPath;$InstallPath\bin", "User")
                $env:Path = [Environment]::GetEnvironmentVariable("Path", "User")
            }
            
            Write-Host "Flutter installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Failed to extract Flutter SDK." -ForegroundColor Red
        }
    } else {
        Write-Host "Failed to download Flutter SDK." -ForegroundColor Red
        Write-Host "Please install manually from: https://flutter.dev/docs/get-started/install/windows" -ForegroundColor Yellow
    }
}
Write-Host ""

# Step 5: Install Android Studio (if not skipped)
if (-not $SkipAndroidStudio) {
    Write-Host "Step 5: Installing Android Studio..." -ForegroundColor Green
    $androidStudioPath = "${env:ProgramFiles}\Android\Android Studio\bin\studio64.exe"
    
    if (-not (Test-Path $androidStudioPath)) {
        Write-Host "Downloading Android Studio..." -ForegroundColor Yellow
        $androidStudioUrl = "https://redirector.gvt1.com/edgedl/android/studio/install/2023.1.1.26/android-studio-2023.1.1.26-windows.exe"
        $androidStudioInstaller = "$env:TEMP\android-studio-installer.exe"
        
        if (Download-File $androidStudioUrl $androidStudioInstaller) {
            Write-Host "Installing Android Studio..." -ForegroundColor Yellow
            Write-Host "This may take several minutes. Please wait..." -ForegroundColor Yellow
            
            Start-Process -FilePath $androidStudioInstaller -ArgumentList "/S" -Wait
            Remove-Item $androidStudioInstaller -Force
            
            Write-Host "Android Studio installed successfully!" -ForegroundColor Green
            Write-Host "Please launch Android Studio and complete the setup wizard." -ForegroundColor Yellow
        } else {
            Write-Host "Failed to download Android Studio." -ForegroundColor Red
            Write-Host "Please install manually from: https://developer.android.com/studio" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Android Studio is already installed." -ForegroundColor Green
    }
    Write-Host ""
}

# Step 6: Verify Flutter installation
Write-Host "Step 6: Verifying Flutter installation..." -ForegroundColor Green
if (Test-Command "flutter") {
    Write-Host "Running flutter doctor..." -ForegroundColor Yellow
    flutter doctor
    
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installation Complete!" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Restart your terminal/command prompt" -ForegroundColor White
    Write-Host "2. Run 'flutter doctor' to check for any remaining issues" -ForegroundColor White
    Write-Host "3. If you installed Android Studio, launch it and complete the setup" -ForegroundColor White
    Write-Host "4. Accept Android licenses: flutter doctor --android-licenses" -ForegroundColor White
    Write-Host ""
    Write-Host "Flutter is now ready for Windows development!" -ForegroundColor Green
} else {
    Write-Host "Flutter installation verification failed." -ForegroundColor Red
    Write-Host "Please restart your terminal and try running 'flutter doctor'" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to exit"
