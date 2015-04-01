# (C) 2012 Dr. Tobias Weltner, MVP PowerShell
# www.powertheshell.com
# you can freely use and distribute this code
# we only ask you to keep this comment including copyright and url
# as a sign of respect. 

<# credits to PowerShell MVP Oisin Grehan for his original work #>
<# credits to PowerShell MVP Shay Levy for his original work #>


add-type -namespace API -name Window -memberdefinition @"
	[DllImport("user32.dll")]  
	public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);  

	public static IntPtr FindWindow(string windowName){
		return FindWindow(null,windowName);
	}

	[DllImport("user32.dll")]
	public static extern bool SetWindowPos(IntPtr hWnd, 
	IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);

	[DllImport("user32.dll")]  
	public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow); 

	static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
	static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);

	const UInt32 SWP_NOSIZE = 0x0001;
	const UInt32 SWP_NOMOVE = 0x0002;

	const UInt32 TOPMOST_FLAGS = SWP_NOMOVE | SWP_NOSIZE;

	public static void MakeTopMost (IntPtr fHandle)
	{
		SetWindowPos(fHandle, HWND_TOPMOST, 0, 0, 0, 0, TOPMOST_FLAGS);
	}

	public static void MakeNormal (IntPtr fHandle)
	{
		SetWindowPos(fHandle, HWND_NOTOPMOST, 0, 0, 0, 0, TOPMOST_FLAGS);
	}

    [StructLayout(LayoutKind.Sequential)]
    public struct MARGINS
    {
       public int left; 
       public int right; 
       public int top; 
       public int bottom; 
    } 

    [DllImport("dwmapi.dll", PreserveSig = false)]
    public static extern void DwmExtendFrameIntoClientArea(IntPtr hwnd, ref MARGINS margins);

    [DllImport("dwmapi.dll", PreserveSig = false)]
    public static extern bool DwmIsCompositionEnabled();
"@


<#
.SYNOPSIS
Enables glass effect for current powershell console.
.EXAMPLE
Enable-AeroGlassTheme
Enables aero glass effects for current powershell console.
#>
Function Enable-AeroGlassTheme
{
  if (([Environment]::OSVersion.Version.Major -gt 5) -and
    [api.window]::DwmIsCompositionEnabled())
  {
    $hwnd = (Get-Process -Id $pid).mainwindowhandle

    $margin = New-Object 'API.Window+margins'

    $script:OldBackground = $host.ui.RawUI.BackgroundColor
    $script:OldForeground = $host.ui.rawui.foregroundcolor
    $host.ui.RawUI.BackgroundColor = 'black'
    $host.ui.rawui.foregroundcolor = 'white'

    $margin.top = -1
    $margin.left = -1
    [System.Console]::Clear()

    [API.Window]::DwmExtendFrameIntoClientArea($hwnd, [ref]$margin)
  }
  else
  {
    Write-Warning 'Aero is either not available or not enabled on this workstation.'
  }
}

<#
.SYNOPSIS
Disables glass effect for current powershell console.
.EXAMPLE
Disable-AeroGlassTheme
Disables aero glass effects for current powershell console.
#>
Function Disable-AeroGlassTheme
{
  if (([Environment]::OSVersion.Version.Major -gt 5) -and
    [api.window]::DwmIsCompositionEnabled())
  {
    $hwnd = (Get-Process -Id $pid).mainwindowhandle
    $margin = New-Object 'API.Window+margins'

    $margin.top = 0
    $margin.left = 0
    $host.ui.RawUI.BackgroundColor = $script:OldBackground
    $host.ui.rawui.foregroundcolor = $script:OldForeground

    [System.Console]::Clear()

    [API.Window]::DwmExtendFrameIntoClientArea($hwnd, [ref]$margin)
  }
  else
  {
    Write-Warning 'Aero is either not available or not enabled on this workstation.'
  }
}


<#
.SYNOPSIS
keeps a window above all other windows
.PARAMETER hwnd
Numeric value representing the window handle for the window to keep topmost.
Optional. When not specified, the current PowerShell window is switched topmost.
.EXAMPLE
Enable-TopMost
Keeps current PowerShell window above all other windows.
.EXAMPLE
Get-Process notepad | Enable-TopMost
Keeps all open notepad windows above all other windows.
#>
Function Enable-TopMost
{
  param
  (
    [Parameter(Position=0,ValueFromPipelineByPropertyName=$true)]
    [Alias('MainWindowHandle')]
    $hWnd=0
  )

  Process
  {
    if ($hwnd -eq 0)
    {
      $hwnd = (Get-Process -Id $PID).MainWindowHandle
    }

    if ($hWnd -ne 0)
    {
      $null = [API.Window]::MakeTopMost($hWnd)
    }
  }
}

<#
.SYNOPSIS
Restores normal behavior for a window and disables its topmost status.
.PARAMETER hwnd
Numeric value representing the window handle for the window to keep topmost.
Optional. When not specified, the current PowerShell window is switched topmost.
.EXAMPLE
Disable-TopMost
Restores normal behavior of current powershell window.
.EXAMPLE
Get-Process notepad | Disable-TopMost
Restores normal mode for all open notepad windows.
#>
Function Disable-TopMost
{
  param
  (
    [Parameter(Position=0,ValueFromPipelineByPropertyName=$true)]
    [Alias('MainWindowHandle')]
    $hWnd=0
  )

  Process
  {
    if ($hwnd -eq 0)
    {
      $hwnd = (Get-Process -Id $PID).MainWindowHandle
    }

    if ($hWnd -ne 0)
    {
      $null = [API.Window]::MakeNormal($hWnd)
    }
  }
}

<#
.SYNOPSIS
Returns application windows based on text found in the Window title bar
.PARAMETER WindowTitle
Text to be found in the window title bar. Use wildcards to find only partial text.
Optional. When not specified, all windows are returned
.EXAMPLE
Get-WindowByTitle -WindowTitle *Notepad*
Returns all window handles for all windows that have "notepad" in their title bar
.EXAMPLE
Get-WindowByTitle
Returns all open application windows
.EXAMPLE
Get-WindowByTitle -WindowTitle *notepad*
Returns all open application windows that have "notepad" in their title bar
#>
Function Get-WindowByTitle
{
  param
  (
    $WindowTitle='*'
  )

  if ($WindowTitle -eq '*')
  {
    Get-Process |
    Where-Object {$_.MainWindowTitle} |
    Select-Object Id,Name,MainWindowHandle,MainWindowTitle
  }
  else
  {
    Get-Process |
    Where-Object {$_.MainWindowTitle -like "*$WindowTitle*"} |
    Select-Object Id,Name,MainWindowHandle,MainWindowTitle
  }
}


Export-ModuleMember -Function Enable-AeroGlassTheme, Disable-AeroGlassTheme, Enable-TopMost, Disable-TopMost, Get-WindowByTitle