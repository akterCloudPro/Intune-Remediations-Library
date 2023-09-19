<#
    .SYNOPSIS 
    Change network connection based on SSID name

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\detection.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast
#>

#Settings
$activeconnections = (Get-NetConnectionProfile).Name
$corporateNetwork = "RastCloudCorporated"
$corporateProfile = "DomainAuthenticated"

#Update the profile category
Get-NetConnectionProfile -Name "$corporateNetwork" | Set-NetConnectionProfile -NetworkCategory $corporateProfile