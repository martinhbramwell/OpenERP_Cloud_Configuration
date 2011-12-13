#! /bin/bash
# script to replace my cloud DNS configuration from files retrieved from GitHub.
cp ./etc/network/interfaces		/etc/network/interfaces
cp ./etc/resolv.conf			/etc/resolv.conf
cp ./etc/hosts				/etc/hosts

#   sudo /etc/init.d/bin9 restart
#   sudo /etc/init.d/networking restart


mkdir -p /etc/bind/zones

cp ./etc/bind/named.conf.options	/etc/bind/
cp ./etc/bind/named.conf.local		/etc/bind/

cp ./etc/bind/zones/*			/etc/bind/zones

