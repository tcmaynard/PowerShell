Strong typing:

PS> $profile.AllUsersAllHosts
C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1

PS> [int]$ID = 12

PS> $ID = 17

PS> $ID = '19'

PS> $ID = 'wrong'
Cannot convert type "string"... 

------------------------------------------------------------

Readonly (Constants):

PS> $a = 1

PS> $a = 100

PS> Set-Variable a -Option ReadOnly

PS> $a
100

PS> $a = 200
Cannot overwrite variable.

PS> Set-Variable a -Option None -Force

PS> $a = 212 

-------------------------------------------------------------

Durable Constants (Session Constants):

Variables in PowerShell are volatile. You can overwrite and delete them – unless you create constants.
Constants can only be created when there is no such variable yet. This line creates a constant named “cannotChange” with a value of 1.
 
New-Variable -Name cannotChange -Value 1 -Option Constant 
 
There is no way for you to get rid of this variable anymore for as long as PowerShell runs. The variable is tied to the current PowerShell session. Constants can be used for sensible information that you do not ever want to change.
You could define constants in your primary profile path, for example:
PS> $profile.AllUsersAllHosts
C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1 
 
If this file exists, PowerShell executes it first whenever any PowerShell starts. If you define constants here – like your company name, important server lists, etc. – this information will be available in all PowerShell hosts and can never be overridden. 

