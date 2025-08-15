Write-Host "Building Word Filler App for Windows..." -ForegroundColor Green
Write-Host ""

# Check if Flutter is installed
try {
    $flutterVersion = flutter --version
    Write-Host "Flutter found:" -ForegroundColor Green
    Write-Host $flutterVersion -ForegroundColor Gray
} catch {
    Write-Host "Error: Flutter is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Flutter from https://flutter.dev/docs/get-started/install/windows" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Getting dependencies..." -ForegroundColor Yellow
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to get dependencies!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Building Windows executable..." -ForegroundColor Yellow
flutter build windows --release

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Build failed! Please check the error messages above." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Build successful!" -ForegroundColor Green
Write-Host ""
Write-Host "The Windows executable is located at:" -ForegroundColor Cyan
Write-Host "build\windows\runner\Release\word_filler_app.exe" -ForegroundColor White
Write-Host ""
Write-Host "You can also find the complete application folder at:" -ForegroundColor Cyan
Write-Host "build\windows\runner\Release\" -ForegroundColor White
Write-Host ""
Write-Host "To create a portable version, copy the entire Release folder." -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to exit"
