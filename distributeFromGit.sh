#! /bin/bash
# script to replace my cloud DNS configuration from files retrieved from GitHub.
cp ./etc/network/interfaces /etc/network/interfaces
cp ./etc/resolv.conf        /etc/resolv.conf
cp ./etc/hosts              /etc/hosts

#   sudo /etc/init.d/networking restart


