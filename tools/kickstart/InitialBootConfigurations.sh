#!/bin/sh
# Starts simple test
#


case "$1" in
start)
#
   mkdir -p /home/yourself/
   cd /home/yourself
   rm -f ./First*
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootConfigurations.sh
   chmod +x ./FirstBootConfigurations.sh
   ./FirstBootConfigurations.sh


;;

*)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

