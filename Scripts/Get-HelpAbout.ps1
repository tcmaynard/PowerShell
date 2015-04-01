<#
  .Synopsis
  Show all the About* topics in grid view
#>
Get-Help about* | Out-GridView -PassThru | Get-Help -ShowWindow
