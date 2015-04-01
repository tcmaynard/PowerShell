<#
.Synopsis
Edit the Network Hosts file (with Admin privs, in case you need them)
#>

function Edit-HostsFile {
  $path = "$Env:windir\system32\drivers\etc\hosts"
  Start-Process -FilePath gvim -ArgumentList $path -Verb runAs
}
