<#
    .SYNOPSIS 
    Create C:\Temp folder and HKLM:\SOFTWARE\$AADName RegKey

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\detection.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast
#>

#Create C:\Temp folder
New-Item -Path C:\Temp -ItemType Directory -Force

#Create RegKey
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo"
$TenantInfoPath = (Get-ChildItem -Path $regPath).Name
$parentPart = Split-Path $TenantInfoPath -Parent
$AADTenantID = Split-Path $TenantInfoPath -Leaf
$AADName = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$AADTenantID" -Name DisplayName).DisplayName
$AADNameNoBlanks = [regex]::Replace($AADName, '\s', '')

New-Item -Path "HKLM:\SOFTWARE\$AADName" -Force