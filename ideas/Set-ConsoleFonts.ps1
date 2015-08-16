#Run as Administrator

$key = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont'

#Set-ItemProperty -Path $key -Name '0' -Value 'Lucida Console'
#Set-ItemProperty -Path $key -Name '00' -Value 'Consolas'

Set-ItemProperty -Path $key -Name '000' -Value 'DejaVu Sans Mono for Powerline'
Set-ItemProperty -Path $key -Name '0000' -Value 'Inconsolata-g'

#Set-ItemProperty -Path $key -Name '00000' -Value '?????'