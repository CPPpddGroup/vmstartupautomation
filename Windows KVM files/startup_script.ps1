#PDD script to change hostname and bootstrap

#get values of win32_computersystem
$cname = Get-WmiObject Win32_ComputerSystem

#generate random string w/ format "WIN7-1234567890"
$hname = "WIN7-"
$hname += ([char[]]([char]'A'..[char]'Z') + 0..9 | sort {get-random})[0..10] -join ''

#rename computer using function of wmi object
$cname.Rename($hname)

#add bootstrap script to runonce
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name 'bootstrap' -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file c:\bootstrap.ps1"

#delete self
Remove-Item $MyINvocation.InvocationName

#restart the computer for changes to take effect
restart-Computer