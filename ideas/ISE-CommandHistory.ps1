#requires -Version 3 
$code =
{
    $text = Get-History |
    Select-Object -ExpandProperty CommandLine |
    Out-String
 
    $file = $psise.CurrentPowerShellTab.Files.Add()
    $file.Editor.Text = $text
}
 
$psise.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Get Command History', $code, 'ALT+C') 
