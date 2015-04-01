Function wget ($thing) 
{ 
  (New-Object Net.WebClient).DownloadString("$thing") 
}
