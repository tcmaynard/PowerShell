<#
.Synopsis
Sign a PowerShell script, using our handy-dandy certificate
.Syntax
Sign-Script <script-name>
#>
Function Sign-Script($script)
{
  Set-AuthenticodeSignature $script @(Get-Childitem $script cert:\CurrentUser\My -codesign)[0]
}
