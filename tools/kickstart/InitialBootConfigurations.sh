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
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootSSHConfigurations.sh
   chmod +x ./FirstBootSSHConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootAntConfigurations.sh
   chmod +x ./FirstBootAntConfigurations.sh
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
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootPlayFwkConfigurations.sh
   chmod +x ./FirstBootPlayFwkConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootSmartGitConfigurations.sh
   chmod +x ./FirstBootSmartGitConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootFitnesseWikiConfigurations.sh
   chmod +x ./FirstBootFitnesseWikiConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootNXConfigurations.sh
   chmod +x ./FirstBootNXConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCyclosConfigurations.sh
   chmod +x ./FirstBootCyclosConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCleanUp.sh
   chmod +x ./FirstBootCleanUp.sh
#
											CNT=0
#
   ./FirstBootConfigurations.sh 2>&1             | tee "ini_${CNT}_initial.log"  && CNT=$((  CNT += 1  ))
   ./FirstBootSSHConfigurations.sh 2>&1          | tee "ini_${CNT}_ssh.log"      && CNT=$((  CNT += 1  ))
   ./FirstBootAntConfigurations.sh 2>&1          | tee "ini_${CNT}_ant.log"      && CNT=$((  CNT += 1  ))
   ./FirstBootJenkinsConfigurations.sh 2>&1      | tee "ini_${CNT}_jenkins.log"  && CNT=$((  CNT += 1  ))
   ./FirstBootLXDEConfigurations.sh 2>&1         | tee "ini_${CNT}_lxde.log"     && CNT=$((  CNT += 1  ))
   ./FirstBootEclipseConfigurations.sh 2>&1      | tee "ini_${CNT}_eclipse.log"  && CNT=$((  CNT += 1  ))
   ./FirstBootPlayFwkConfigurations.sh 2>&1      | tee "ini_${CNT}_play.log"     && CNT=$((  CNT += 1  ))
   ./FirstBootSmartGitConfigurations.sh 2>&1     | tee "ini_${CNT}_smartgit.log" && CNT=$((  CNT += 1  ))
   ./FirstBootFitnesseWikiConfigurations.sh 2>&1 | tee "ini_${CNT}_fitwiki.log"  && CNT=$((  CNT += 1  ))
   ./FirstBootNXConfigurations.sh 2>&1           | tee "ini_${CNT}_NX.log"       && CNT=$((  CNT += 1  ))
   ./FirstBootCyclosConfigurations.sh 2>&1       | tee "ini_${CNT}_cyclos.log"   && CNT=$((  CNT += 1  ))
   ./FirstBootCleanUp.sh			# Don't allow these scripts to be called ever again.
#

;;

*)
        echo "Usage: $0 {start}"
        exit 1
esac

