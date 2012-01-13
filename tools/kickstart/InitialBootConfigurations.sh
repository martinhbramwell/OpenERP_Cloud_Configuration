#!/bin/sh
# 


case "$1" in
start)
#
   mkdir -p /home/yourself/
   cd /home/yourself

   rm -f ./FirstBoot*

   export CAN_WE_SEE_THIS_INSIDE_THE_SCRIPTS="YES WE CAN!"
##   export http_proxy=http://openerpns.warehouseman.com:3128/
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootConfigurations.sh
   chmod +x ./FirstBootConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootJenkinsConfigurations.sh
   chmod +x ./FirstBootJenkinsConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootLXDEConfigurations.sh
   chmod +x ./FirstBootLXDEConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootEclipseConfigurations.sh
   chmod +x ./FirstBootEclipseConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootSmartGitConfigurations.sh
   chmod +x ./FirstBootSmartGitConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCleanUp.sh
   chmod +x ./FirstBootCleanUp.sh
#
   ./FirstBootConfigurations.sh
   ./FirstBootJenkinsConfigurations.sh
   ./FirstBootLXDEConfigurations.sh
   ./FirstBootEclipseConfigurations.sh
   ./FirstBootSmartGitConfigurations.sh
   ./FirstBootCleanUp.sh			# Don't allow these scripts to be called ever again.
#

;;

*)
        echo "Usage: $0 {start}"
        exit 1
esac

