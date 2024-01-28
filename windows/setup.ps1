
function ReloadPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Log {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    $currentDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Output "$currentDateTime $Message"
}

function Copy-File {
    param (
        [Parameter(Mandatory)]
        [string]$Source,
        [Parameter(Mandatory)]
        [string]$Destination
    )
    Log "Copying $Source to $Destination"
    New-Item  -Force -Path (Split-Path -Path $Destination) -Type Directory | Out-Null
    Copy-Item -Force -Path "$PSScriptRoot\..\$Source" "$Destination"
}


try {
    Log "Check winget exists"
    Get-Command winget | Out-Null
    Log "Yes!"
}
catch {
    Log "Install winget"
    $URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $URL = (Invoke-WebRequest -UseBasicParsing -Uri $URL).Content | ConvertFrom-Json |
            Select-Object -ExpandProperty "assets" |
            Where-Object "browser_download_url" -Match '.msixbundle' |
            Select-Object -ExpandProperty "browser_download_url"
    
    # download
    Log "Downloading winget from $URL"
    Invoke-WebRequest -Uri $URL -OutFile "WingetSetup.msix" -UseBasicParsing
    Log "Installing winget"
    Add-AppxPackage -Path "WingetSetup.msix"
    Remove-Item "WingetSetup.msix"
}

ReloadPath

Log "Installing winget packages"
$Pkgs = "Git.Git", "Microsoft.VisualStudioCode", "Starship.Starship", "Microsoft.PowerShell"
foreach ($P in $Pkgs) {
    Log "Installing $P"
    winget install -e --id $P
}

Copy-File "files\.config\starship.toml" "$HOME\.config\starship.toml"

# Default Windows old powershell
Copy-File "windows\Microsoft.PowerShell_profile.ps1" "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
# winget powershell
Copy-File "windows\Microsoft.PowerShell_profile.ps1" "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"


# Git config
Copy-File "files\.gitconfig" "$HOME\.gitconfig"

# Nerd Fonts
Log "Installing FiraCode Font"
.\windows\NerdFontInstaller\NerdFontInstaller.ps1 FiraCode