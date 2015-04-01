<#
  .Synopsis
   Get rid of the Xmarks directories
#>

function rmXmarks
{
  cd \Program Files (x86)\
  remove-item xmarks -recurse
}
