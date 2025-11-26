<#
Script: install_xampp.ps1
Purpose: Download and launch XAMPP installer on Windows, then optionally copy this project into C:\xampp\htdocs\portfolio.

Usage examples:
  # Download default URL and run installer; after install press Enter to continue and optionally copy project
  pwsh -ExecutionPolicy Bypass -File .\scripts\install_xampp.ps1 -CopyProject -ProjectPath 'C:\Users\Lenovo\OneDrive\Desktop\mini project'

  # Provide a custom XAMPP download URL
  pwsh -ExecutionPolicy Bypass -File .\scripts\install_xampp.ps1 -DownloadUrl 'https://www.apachefriends.org/xampp-files/8.2.12/xampp-windows-x64-8.2.12-0-VS16-installer.exe' -CopyProject

Notes:
- The direct-download URL may change. If download fails the script will open the XAMPP download page for manual download.
- Run PowerShell as Administrator if you want to copy into C:\xampp\htdocs without permission issues.
#>

param(
    [string]$DownloadUrl = 'https://www.apachefriends.org/xampp-files/8.2.12/xampp-windows-x64-8.2.12-0-VS16-installer.exe',
    [switch]$CopyProject,
    [string]$ProjectPath = (Get-Location).ProviderPath,
    [string]$HtdocsPath = 'C:\xampp\htdocs\portfolio'
)

function Write-Info($msg){ Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-ErrorMsg($msg){ Write-Host "[ERROR] $msg" -ForegroundColor Red }

Write-Info "Installer download URL: $DownloadUrl"

$dest = Join-Path ([Environment]::GetFolderPath('UserProfile')) 'Downloads\xampp-installer.exe'

try{
    Write-Info "Downloading XAMPP installer to: $dest"
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $dest -UseBasicParsing -ErrorAction Stop
    Write-Info "Download complete. Launching installer..."
    Start-Process -FilePath $dest -Verb RunAs
}catch{
    Write-ErrorMsg "Automatic download failed: $($_.Exception.Message)"
    Write-Info "Opening XAMPP download page in your browser. Please download the Windows installer manually and run it."
    Start-Process 'https://www.apachefriends.org/index.html'
    Write-Info "After installing XAMPP, re-run this script with -CopyProject to copy the project into htdocs. Exiting."
    exit 1
}

Write-Info "When the installer finishes, close the installer window and press Enter here to continue (the script will then copy the project if -CopyProject was specified)."
Read-Host -Prompt 'Press Enter after completing XAMPP installation'

if($CopyProject){
    if(-Not (Test-Path $ProjectPath)){
        Write-ErrorMsg "Project path not found: $ProjectPath"
        exit 1
    }

    # Ensure XAMPP folder exists
    if(-Not (Test-Path 'C:\xampp')){
        Write-ErrorMsg "C:\xampp not found. Make sure XAMPP was installed to C:\xampp or adjust the script."
        $open = Read-Host 'Open XAMPP download page? (y/n)'
        if($open -eq 'y'){ Start-Process 'https://www.apachefriends.org/index.html' }
        exit 1
    }

    Write-Info "Copying project from:`n  $ProjectPath`n to:`n  $HtdocsPath"
    try{
        # Remove existing destination if present
        if(Test-Path $HtdocsPath){
            Write-Info "Removing existing folder: $HtdocsPath"
            Remove-Item -Recurse -Force -Path $HtdocsPath
        }
        Copy-Item -Path $ProjectPath -Destination $HtdocsPath -Recurse -Force
        Write-Info "Copy complete. Open http://localhost/portfolio/index.html to view the site."
    }catch{
        Write-ErrorMsg "Failed to copy project: $($_.Exception.Message)"
        Write-Info "You can manually copy the project folder to C:\xampp\htdocs\portfolio after installation."
        exit 1
    }
}else{
    Write-Info "-CopyProject not specified. Installation step completed."
}

Write-Info "Script finished. Start XAMPP Control Panel and ensure Apache and MySQL are running."
Write-Info "If you copied the project, open: http://localhost/portfolio/index.html"
