# PowerShell Profile Configuration
# Location: $PROFILE (usually Documents\PowerShell\Microsoft.PowerShell_profile.ps1)

# Import modules with error handling
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
} else {
    Write-Warning "posh-git module not found. Install with: Install-Module posh-git -Scope CurrentUser"
}

if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
} else {
    Write-Warning "PSReadLine module not found. Install with: Install-Module PSReadLine -Scope CurrentUser"
}

# Initialize starship prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
} else {
    Write-Warning "Starship not found. Install from: https://starship.rs/"
}

# Useful aliases
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String

# Functions
function which($name) {
    Get-Command $name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
}

function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# Git shortcuts
function gs { git status }
function ga { git add $args }
function gc { git commit $args }
function gp { git push }
function gl { git log --oneline -10 }

# Environment setup
$env:EDITOR = if (Get-Command code -ErrorAction SilentlyContinue) { "code" } else { "notepad" }

# Display loaded profile info
Write-Host "PowerShell Profile Loaded" -ForegroundColor Green
Write-Host "Profile Path: $PROFILE" -ForegroundColor Gray
