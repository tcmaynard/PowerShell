<#
 # .Synopsis
 # v -- Invoke GVim on $filename
 #
 # .Description
 # See if a file exists before editing it
 #
 # If it does not, and it is (or will be) a PowerShell script,
 # copy the boilerplate first
 #
 # .Parameter $filename
 # The [Path]Name of the file to edit
 #
 # .Example
 # v ../some/newfile.ps1
 # This example is for a new file.  It is (or will be) a PowerShell script, so the
 # documentation boilerplate will be inserted (copied) to the file first.
 #
 # .Example
 # v deeper/in/oldfile.txt
 # This example is for a pre-existing file.  Since the file already exists -- 
 # regardless of filetype -- it will simply be opened for editing.
 #>
Function v ($filename)
{
    if (-not (Test-Path $filename)) {                   # New file?
        if ($filename.ToLower().contains(".ps1")) {     # PowerShell script?
            Copy-Item $here\PSSkel.ps1 $filename        # Start with the boilerplate
        } else {
          $filename = ""
        }
    }

    gvim $filename
 }
