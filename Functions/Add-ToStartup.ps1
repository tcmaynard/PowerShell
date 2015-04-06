function AddToStartUp ($executable)
{
  Copy-Item $executable "C:\Users\Tom\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
#  Copy-Item $executable "C:\Users\Tom.000\AppData\Roaming\Microsoft\Windows\Start Menu\Startup\$executable"
}
