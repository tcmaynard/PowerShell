<#
  .Synopsis
   Show the current CPU utilization (all cores?  Dunno!)

  .Description
   Gleaned from the Interwebs, at http://www.ntweekly.com/?p=160
#>

function Show-CPU
{
  Get-WmiObject win32_processor | Select-Object LoadPercentage | Format-List
}