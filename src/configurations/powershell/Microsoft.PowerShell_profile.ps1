Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine
#Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
#Install-Module -Name PSReadLine -AllowPrerelease -Force
Set-PSReadLineOption -PredictionSource History
Invoke-Expression (&starship init powershell)
#Invoke-Expression (oh-my-posh --init --shell pwsh --config ~/.ripuhan.omp.json)
