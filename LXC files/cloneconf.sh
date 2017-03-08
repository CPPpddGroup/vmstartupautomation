#!/bin/sh

echo "GUEST CONFIGURATION AFTER CLONING"
echo

rhex=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 8`
nh="Ubuntu-$rhex"

if [ "$1" = "" ]; then
  hostname $nh
  echo -n "The hostname is now $nh"
else
  nh="$1"
fi

echo
echo "This script will configure the host with the following settings:"
echo Hostname: $nh
echo
echo /etc/hostname:
echo $nh
echo
echo /etc/hosts:
cat /usr/local/etc/clonehosts | sed -e "s/nh/$nh/g"
echo
echo $nh > /etc/hostname
cat /usr/local/etc/clonehosts | sed -e "s/nh/$nh/g" > /etc/hosts
echo
echo "Bootstrapping to Chef server..."

if test -f "/etc/chef/client.pem"; then 
	rm /etc/chef/client.pem
	fi
/usr/bin/chef-client
echo
echo "Removing 'cloneconf.sh' file..."
if grep -Fxq 'sh /usr/local/sbin/cloneconf.sh' /etc/rc.local; then 
	sed -i '/sh \/usr\/local\/sbin\/cloneconf.sh/d' /etc/rc.local
	fi
rm -- "$0"
echo
echo "The clone configuration has completed. Hostname changed and bootstrapped to Chef server."
echo
#for i in 5 4 3 2 1; do echo "Rebooting in $i seconds (Ctrl-C to abort)"; sleep 1; done
#reboot
