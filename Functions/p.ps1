<#
 # Make the PATH/CLASSPATH easier to read
 #>

function p {
  write-host "Path:"
  $env:path -split ";"

  write-host " "
  write-host "Classpath:"
  $env:classpath -split ";"
}
