<#
 # Tom's custom profile
 # 
 # Poached mightly from "scottmuc/poshfiles" on GitHub
 # https://github.com/scottmuc/poshfiles
 #
 # Revision History:
 # <0>  30-Aug-2014 Birthday
 #>

# Who's your daddy?
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Function loader
#
# To add functions, drop scripts in the Functions folder, or insert
# them inline in this file (which skips testing)

<#
# Set the "global" script repo (pslib)
New-PSDrive -name pslib -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Scripts | Out-Null
#Set-Location pslib:
#>

# Set console colors to match privilege level
$a = (Get-Host).UI.RawUI
if ($a.WindowTitle -match "Administrator") {
  #$a.BackgroundColor = "DarkRed";
  $a.ForegroundColor = "Yellow";
  Set-Location $env:homedrive\$env:homepath
}

# Convenience cmdlet aliases
Set-Alias mob Measure-Object

# Simple functions
#Function Get-Music { New-PSDrive -Name music -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Music }
Function cd... { Set-Location ..\\.. }
Function home  { Set-Location $env:homedrive\$env:homepath }
Function ld    { Get-Childitem -Attributes D }
Function lf    { Get-Childitem -File }
Function lsp   { Get-Childitem | More }
Function music { Set-Location \\SEAGATE-3F3BF2\Public\Music }
Function open ($thing) { Start-Process .\$thing }
Function su    { Start-Process PowerShell -verb runAs }
Function tab   { Start-Process PowerShell }
Function which ($app) { Get-Command $app | Format-Table Path }

# More elaborate functions
# Copy command history to clipboard
function Clip-History { (Get-History).CommandLine | clip }

# Edit the network Hosts file
function Show-HostsFile {
   $Path = "$env:windir\system32\drivers\etc\hosts"
   Start-Process -FilePath gvim -ArgumentList $Path -Verb runas
}

# Load posh-git example profile
#. 'C:\Users\Tom.000\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

# Tweak the prompt
function prompt
{

  Write-Host ($env:username+"@"+$env:userdomain+"  ") -NoNewLine -ForegroundColor yellow
  Write-Host $($(Get-Location).Path.replace($home,"~")) -NoNewLine -ForegroundColor DarkCyan
  Write-Host " " -NoNewLine
  $global:GitStatus = Get-GitStatus
  Write-GitStatus $GitStatus
  Write-Host
  Write-Host $(if ($nestedpromptlevel -ge 1) { ">>" }) -NoNewLine -ForegroundColor Yellow
  Write-Host "$" -ForegroundColor Yellow -NoNewLine
  return " "
}

# Crack open functions to see the code
function Show-Function ($func) { (Get-Command $func).ScriptBlock }

# Tweak the PATH
$d1 = "C:\Users\Tom.000\bin;"
$d2 = "C:\Users\Tom.000\Documents\WindowsPowerShell\Scripts;"

$env:path = $d1 + $d2 + $env:path
