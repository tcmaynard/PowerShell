<#
 # Tom's custom profile
 # 
 # Poached mightly from "scottmuc/poshfiles" on GitHub
 # https://github.com/scottmuc/poshfiles
 #
 # Revision History:
 # <0>  30-Aug-2014 Birthday
 # <1>  31-Aug-2014 Still working
 # <2>  01-Sep-2014 Up and running, just updates from now on
 # <3>  26-Sep-2014 Prompt suddenly broke, do explicit imports
 #                  Add aliases for AeroGlassTheme on/off
 # <4>  12-Oct-2014 Add "jobs" function for running procs
 # <5>  21-Dec-2014 Add "Priv-Explore" for admin File Explorer
 #                  Add "sudo" for one-time, one-command invocation
 # <6>  05-Feb-2015 Add "xvim" and "Vim2Dos"
 #  <7> 06-Feb-2015 Add "PSVersion" and "rmrf"
 #  <8> 07-Feb-2015 Rename startup location from "$here" to "$PSHome"
 #  <9> 08-Feb-2015 Undo #7: Error at login.  Easier to revert than
 #                  debug.  Perhaps another day.
 #  <10>  10-Feb-2015 Import *all* modules explicitly (another failure
 #                    to auto-load
 #  <11>  01-Mar-2015 Change error output colors
 #  <12>  29-Mar-2015 Set $OutputEncoding to UTF-8
 #  <13>  31-Mar-2015 Smarten up the module loading
 #>

# Who's your daddy?
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# Function loader
#
# To add functions, drop scripts in the Functions folder, or insert
# them inline in this file (which skips testing)
Resolve-Path $here\Functions\*.ps1 |
  Where-Object { -not ($_.ProviderPath.Contains(".Tests")) } |
  Foreach-Object { . $_.ProviderPath }

# Import posh-git explicitly (it suddenly quit working, and
# messed up the Prompt) -- ditto for all the rest.
Resolve-Path $here\Modules\* |
  Foreach-Object { Import-Module $_ }
#Import-Module $here\modules\posh-git
#Import-Module $here\modules\go
#Import-Module $here\modules\PsGet
#Import-Module $here\modules\PsUrl

# Make error messages easier to read
$host.privatedata.ErrorBackgroundColor = $host.ui.rawui.BackgroundColor
$host.privatedata.ErrorForegroundColor = "Magenta"

# Set $OutputEncoding to a sensible value
$OutputEncoding = New-Object -typename System.Text.UTF8Encoding

<#
# Set the "global" script repo (pslib)
New-PSDrive -name pslib -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Scripts | Out-Null
#Set-Location pslib:
#>

# Inline Aliases, Functions, and Variables
# Convenience cmdlet aliases
Set-Alias GUI-Command Show-Command
Set-Alias mob Measure-Object
Set-Alias ton Enable-AeroGlassTheme
Set-Alias toff Disable-AeroGlassTheme

# Simple functions
#Function Get-Music { New-PSDrive -Name music -PSProvider Filesystem -Root \\SEAGATE-3F3BF2\Public\Music }
Function cd... { Set-Location ..\\.. }
function Clip-History { (Get-History).CommandLine | clip }
Function home  { Set-Location $env:homedrive\$env:homepath }
Function jobs  { Get-Process | Measure-Object | grep "Count" }
Function ld    { Get-Childitem -Attributes D }
Function lf    { Get-Childitem -File }
Function lsp   { Get-Childitem | More }
Function music { Set-Location \\SEAGATE-3F3BF2\Public\Music }
Function open ($thing) { Start-Process .\$thing }
function p     { $Env:Path -Split ";" }
Function Priv-Explore { Start-Process explorer -verb runAs }
Function PSVersion { $PSVersionTable.PSVersion }
Function rmrf ($dir)  { Remove-Item .\$dir -recurse -force }
function Show-Function ($func) { (Get-Command $func).ScriptBlock }
Function su    { Start-Process PowerShell -verb runAs }
Function sudo ($cmd) { Start-Process $cmd -verb runAs }
Function tab   { Start-Process PowerShell }
Function which ($app) { Get-Command $app | Format-Table Path }
Function xvim  { gvim --noplugin }

# Complex functions
Function Vim2Dos {
  Get-ChildItem *.vim -recurse | ForEach-Object { unix2dos $_ }
}

# Tweak the PATH
$paths = @(
  "C:\Users\Tom.000\bin",
  "C:\Users\Tom.000\Documents\WindowsPowerShell\Scripts",
  $($Env:Path)
)

$env:Path = [String]::Join(";", $paths)
