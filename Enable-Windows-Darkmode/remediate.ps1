$regpath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$regname = "AppsUseLightTheme"
$regname1 = "SystemUsesLightTheme"
$regvalue = "0"
$regtype = "DWORD"


New-ItemProperty -LiteralPath $regpath -Name $regname -Value $regvalue -PropertyType $regtype -Force -ea SilentlyContinue
New-ItemProperty -LiteralPath $regpath -Name $regname1 -Value $regvalue -PropertyType $regtype -Force -ea SilentlyContinue