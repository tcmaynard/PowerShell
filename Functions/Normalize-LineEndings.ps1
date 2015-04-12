<#
  .Synopsis
   Fix up downloaded files to restore line breaks
#>

function Normalize-LineEndings($filename)
{
  Get-Content $filename | Set-Content -Path "fixfile"
}
