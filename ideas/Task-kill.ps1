Get-Process | 
  Where-Object { $_.MainWindowHandle -ne 0 } |
  Select-Object -Property Name, Description, MainWindowTitle, Company, ID | 
  Out-GridView -Title 'Choose Application to Kill' -PassThru | 
  Stop-Process -WhatIf 
