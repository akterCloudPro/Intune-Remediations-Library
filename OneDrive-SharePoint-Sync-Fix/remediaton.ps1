<#
    .SYNOPSIS 
    OneDrive SharePoint Library Sync fix tool

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\detection.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast
#>

$RegPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts\Business1"
$KeyName = "TimerAutoMount"
$Type = "QWORD"
$Value = 1

Set-ItemProperty -Path $RegPath -Name $KeyName -Type $Type -Value $Value 