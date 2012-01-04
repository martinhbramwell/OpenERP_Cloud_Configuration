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
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootJenkinsConfigurations.sh
   chmod +x ./FirstBootJenkinsConfigurations.sh
   ./FirstBootJenkinsConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCleanUp.sh
   chmod +x ./FirstBootCleanUp.sh
   ./FirstBootCleanUp.sh
#

;;

*)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

