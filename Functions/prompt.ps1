<#
.Synopsis
Tweak the prompt the way I like it
Viz:
  Tom@Venus ~/foo/bar/baz [master ...]
  $
.Note
The GitStatus information requires posh-git (and thus psget, I believe)
#>

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
