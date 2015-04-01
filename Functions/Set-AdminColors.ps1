<#
.Synopsis
Set console colors to match privilege level
#>
$a = (Get-Host).UI.RawUI
if ($a.WindowTitle -match "Administrator") {
  #$a.BackgroundColor = "DarkRed";
  $a.ForegroundColor = "Yellow";
  Set-Location $env:homedrive\$env:homepath
}
