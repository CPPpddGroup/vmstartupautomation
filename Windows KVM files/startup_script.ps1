#PDD script to change hostname and bootstrap

#generate random string w/ format "WIN7-1234567890"
$hname = "WIN7-"
$hname += ([char[]]([char]'A'..[char]'Z') + 0..9 | sort {get-random})[0..10] -join ''

#rename computer using wmi
Rename-Computer -NewName $hname

#bootstrap
chef-client -E _default

#delete self
Remove-Item $MyINvocation.InvocationName

#restart the computer
#restart-Computer