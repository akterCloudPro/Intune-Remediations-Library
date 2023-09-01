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


#Get AAD Tenant Name to use as Registry Key name
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo"
$TenantInfoPath = (Get-ChildItem -Path $regPath).Name
$parentPart = Split-Path $TenantInfoPath -Parent
$AADTenantID = Split-Path $TenantInfoPath -Leaf
$AADName = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$AADTenantID" -Name DisplayName).DisplayName
$AADNameNoBlanks = [regex]::Replace($AADName, '\s', '')

#Script variables
$folder = $null
$regKey = $null
    
#Temp folder
if (Test-Path -Path "C:\Temp" -PathType Container) {
    #Write-Host "The folder C:\Temp exists."
    $folder = $true
}
else {
    #Write-Host "The folder C:\Temp does not exist."
    $folder = $false
}

#Registry key
if (Test-Path -Path "HKLM:\SOFTWARE\$AADName") {
    #Write-Host "The Key HKLM:\SOFTWARE\$AADName exists."
    $regKey = $true
}
else {
    #Write-Host "The Key HKLM:\SOFTWARE\$AADName does not exists."
    $regKey = $false
}

#Detect if remediation needs to run
if ($folder -eq $true -and $regKey -eq $true) {
    #Write-Host "The Temp folder and Registry Key exist."
    return 0
}
else {
    #Write-Host "Either the Temp folder or the Registry key are missing - or both."
    return 1
}
