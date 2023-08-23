<#
    .SYNOPSIS 
    Change WinVer and OEM Info

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\remediation.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast
#>

$BrandingContent = @"
RegKeyPath,Key,Value
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportURL","https://support.rastcloud.com/"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","Manufacturer","RastCloud"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportHours","Standard: 24-7-365"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportPhone","+49 123456789"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion","RegisteredOwner","RastCloud"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion","RegisteredOrganization","RastCloud"
"@

$Branding = $BrandingContent | ConvertFrom-Csv -delimiter ","

foreach ($Brand in $Branding) {

    IF (!(Test-Path ($Brand.RegKeyPath))) {
        Write-Host ($Brand.RegKeyPath) " does not exist. Will be created."
        New-Item -Path $RegKeyPath -Force | Out-Null
    }
    IF (!(Get-Item -Path $($Brand.Key))) {
        Write Host $($Brand.Key) " does not exist. Will be created."
        New-ItemProperty -Path $($Brand.RegKeyPath) -Name $($Brand.Key) -Value $($Brand.Value) -PropertyType STRING -Force
    }
    
    $ExistingValue = (Get-Item -Path $($Brand.RegKeyPath)).GetValue($($Brand.Key))
    if ($ExistingValue -ne $($Brand.Value)) {
        Write-Host $($Brand.Key) " not correct value. Will be set."
        Set-ItemProperty -Path $($Brand.RegKeyPath) -Name $($Brand.Key) -Value $($Brand.Value) -Force
    }
    else {
        Write-Host $($Brand.Key) " is correct"
    }
}

Exit 0
