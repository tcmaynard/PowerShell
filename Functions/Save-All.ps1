<#
.Synopsis
  Copy all Windows PowerShell files ($profile, functions, scripts)
  to OneDrive for global access ("Poor Man's Git")

.Description
  Copy everything from `$here` to `$home\OneDrive\PowerShell` so that
  it is available from anywhere (including the Web, via OneDrive.com)

.Example
  > Save-All

.Notes
  Windows RT does not support the full PowerShell v4.0 language, and
  none of these scripts are signed, so a wholesale clone is going to 
  create almost as much work as it is intended to save.  Retrieve from
  OneDrive with caution if the destination is Windows RT.
 #>
function Save-All
{
  # Ensure the two profiles match
  $params = @{        Path="C:\Users\Tom.000\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1";
               Destination="C:\Users\Tom.000\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1" }
  Copy-Item @params -Force

  # Stow everything on OneDrive
  $params = @{        Path="C:\Users\Tom.000\Documents\WindowsPowerShell\*";
               Destination="C:\Users\Tom.000\OneDrive\PowerShell" }
  Copy-Item @params -Recurse -Force
}
