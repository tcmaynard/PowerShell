# classic: 
Get-ChildItem -Path c:\windows -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue 
 
 
# Splatting 
$params = @{}
$params.Path = 'c:\windows'
$params.Filter = '*.ps1'
$params.Recurse = $true
$params.ErrorAction = 'SilentlyContinue'
Get-ChildItem @params 

