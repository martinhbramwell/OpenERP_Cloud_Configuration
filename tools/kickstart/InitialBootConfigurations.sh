#!/bin/sh
# Starts simple test
#


case "$1" in
start)
#
	mkdir -p /home/yourself/tmp
	cd /home/yourself/tmp

   whoami > /home/yourself/tmp/pwd.txt
   pwd >> /home/yourself/tmp/pwd.txt
   cd ~/
   pwd >> /home/yourself/tmp/pwd.txt
   cat /home/yourself/tmp/pwd.txt

#	rm -f ./First*
#	wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootConfigurations.sh
#	chmod +x ./FirstBootConfigurations.sh

;;

*)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

