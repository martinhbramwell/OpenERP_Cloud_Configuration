#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
mkdir -p ./etc/network
mkdir -p ./etc/bind/zones
cp -u /etc/network/interfaces ./etc/network/interfaces
cp -u /etc/resolv.conf ./etc/resolv.conf
cp -u /etc/hosts ./etc/hosts

cp -u /etc/bind/named.conf.options ./etc/bind/
cp -u /etc/bind/named.conf.local ./etc/bind/

cp -u /etc/bind/zones/* ./etc/bind/zones


