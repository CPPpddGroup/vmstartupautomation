#small script to bootstrap after restart

#bootstrap
chef-client -E _default

#delete self
Remove-Item $MyINvocation.InvocationName