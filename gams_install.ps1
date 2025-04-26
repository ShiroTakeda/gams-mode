# gams_install.ps1 - PowerShell script to install GAMS on Windows

param (
    [Parameter(Mandatory=$true)]
    [string]$GamsVersion,

    [Parameter(Mandatory=$false)]
    [string]$InstallDir
)

# Show execution information
Set-PSDebug -Trace 1

# Define temporary directory and file path
$TempDir = [System.IO.Path]::GetTempPath() + [System.Guid]::NewGuid().ToString()
New-Item -ItemType Directory -Path $TempDir | Out-Null
$FileName = "windows_x64_64.exe"
$FilePath = Join-Path -Path $TempDir -ChildPath $FileName

# Define URL
$Url = "https://d37drm4t2jghv5.cloudfront.net/distributions/$GamsVersion/windows/$FileName"

# Download the installer
Write-Host "Downloading GAMS $GamsVersion from $Url..."
try {
    Invoke-WebRequest -Uri $Url -OutFile $FilePath
}
catch {
    Write-Error "Failed to download GAMS installer: $_"
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# Run the installer with silent options
Write-Host "Installing GAMS $GamsVersion"
try {
    Start-Process -FilePath $FilePath -ArgumentList "/SP- /SILENT /installAllUsers=no /currentUser /DIR=`"$InstallDir\gams$GamsVersion`" /desktopIcons=no" -Wait

    # Check if installation was successful
    $GamsExePath = Join-Path -Path "C:\GAMS\gams$GamsVersion" -ChildPath "gams.exe"
    if (Test-Path -Path $GamsExePath) {
        Write-Host "GAMS $GamsVersion installed successfully!"
        # Output the installation path for capture by the Emacs function
        Write-Output "C:\GAMS\gams$GamsVersion"
    } else {
        Write-Error "GAMS installation failed. Could not find gams.exe in the installation directory."
        exit 1
    }
}
catch {
    Write-Error "Failed to install GAMS: $_"
    exit 1
}
finally {
    # Clean up
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
