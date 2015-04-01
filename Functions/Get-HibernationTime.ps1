<#
.SYNOPSIS
Get Sleep and Hibernation Times

.DESCRIPTION
A function that reads the appropriate event log entries and returns a table with 
details, reporting when the computer was put into sleep mode, and how long the computer 
remained in sleep mode

From: PowerShell.com "Tip of the Day" (Idera)
#>

function Get-HibernationTime
{
  # get hibernation events
  Get-EventLog -LogName system -InstanceId 1 -Source Microsoft-Windows-Power-TroubleShooter |
  ForEach-Object {    
    # create new object for results
    $result = 'dummy' | Select-Object -Property ComputerName, SleepTime, WakeTime, Duration
    
    # store details in new object, convert datatype where appropriate
    [DateTime]$result.Sleeptime = $_.ReplacementStrings[0]
    [DateTime]$result.WakeTime = $_.ReplacementStrings[1]
    $time = $result.WakeTime - $result.SleepTime
    $result.Duration = ([int]($time.TotalHours * 100))/100
    $result.ComputerName = $_.MachineName
    
    # return result
    $result
  }
} 