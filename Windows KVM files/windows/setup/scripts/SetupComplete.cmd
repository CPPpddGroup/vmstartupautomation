del /Q /F c:\windows\system32\sysprep\unattend.xml
del /Q /F c:\windows\panther\unattend.xml

powershell.exe -executionpolicy bypass -file c:\startup_script.ps1