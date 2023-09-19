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
$corporateNetwork = "CorporateNetwork"
$corporateProfile = "Private"

#Check if profile update is needed
if($activeconnections -contains $corporateNetwork){
    $currentProfile = (Get-NetConnectionProfile -Name $corporateNetwork).NetworkCategory
    if ($currentProfile -ne $corporateProfile){
        Write-Host "Firewall profile is not $corporateProfile. Update needed."
        return 1
    } else {
        Write-Host "Firewall profile is $corporateProfile. No update needed."
        return 0
    }
}
