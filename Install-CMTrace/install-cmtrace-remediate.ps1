<#
Version: 1.0
Author: 
- Joey Verlinden (joeyverlinden.com)
- Andrew Taylor (andrewstaylor.com)
- Florian Slazmann (scloud.work)
- Jannik Reinhard (jannikreinhard.com)
Script: install-cmtrace-remediate.ps1
Description: Installs CMTrace to c:\windows\system32
Hint: This is a community script. There is no guarantee for this. Please check thoroughly before running.
Version 1.0: Init
Run as: System
Context: 64 Bit
#> 

$ownRepoUri = "https://github.com/niklasrast/niklasrast/raw/main/CMTrace.exe"

invoke-webrequest -uri $ownRepoUri -outfile "C:\Windows\System32\cmtrace.exe"

New-Item -Path HKLM:\SOFTWARE\Classes\.lo_ -Value "Log.File" -Force -ErrorAction SilentlyContinue
New-Item -Path HKLM:\SOFTWARE\Classes\.log -Value "Log.File" -Force -ErrorAction SilentlyContinue
New-Item -Path HKLM:\SOFTWARE\Classes\Log.File\shell\open\command -Value "`"C:\Program Files (x86)\IntuneSystemTrayV2\CMTrace.exe`" `"%1`"" -Force -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Force -ErrorAction SilentlyContinue
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Name "Version" -Value 1 -PropertyType String -Force -ErrorAction SilentlyContinue
New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\CMtrace" -Name "StubPath" -Value "reg.exe ADD HKCU\Software\Microsoft\Trace32 /v ""Register File Types"" /d 0 /f" -PropertyType ExpandString -Force -ErrorAction SilentlyContinue
