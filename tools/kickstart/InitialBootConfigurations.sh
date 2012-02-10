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
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootMySqlConfigurations.sh
   chmod +x ./FirstBootMySqlConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootRunDeckConfigurations.sh
   chmod +x ./FirstBootRunDeckConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCyclosConfigurations.sh
   chmod +x ./FirstBootCyclosConfigurations.sh
#
   wget https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master/tools/kickstart/FirstBootCleanUp.sh
   chmod +x ./FirstBootCleanUp.sh
#
											CNT=0
											NUM=0
#
   ./FirstBootConfigurations.sh 2>&1             | tee "ini_${NUM: -3}_initial.log"  && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootSSHConfigurations.sh 2>&1          | tee "ini_${NUM: -3}_ssh.log"      && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootJenkinsConfigurations.sh 2>&1      | tee "ini_${NUM: -3}_jenkins.log"  && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootAntConfigurations.sh 2>&1          | tee "ini_${NUM: -3}_ant.log"      && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootRunDeckConfigurations.sh 2>&1      | tee "ini_${NUM: -3}_cyclos.log"   && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootLXDEConfigurations.sh 2>&1         | tee "ini_${NUM: -3}_lxde.log"     && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootEclipseConfigurations.sh 2>&1      | tee "ini_${NUM: -3}_eclipse.log"  && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootPlayFwkConfigurations.sh 2>&1      | tee "ini_${NUM: -3}_play.log"     && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootSmartGitConfigurations.sh 2>&1     | tee "ini_${NUM: -3}_smartgit.log" && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootFitnesseWikiConfigurations.sh 2>&1 | tee "ini_${NUM: -3}_fitwiki.log"  && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootNXConfigurations.sh 2>&1           | tee "ini_${NUM: -3}_NX.log"       && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootMySqlConfigurations.sh 2>&1        | tee "ini_${NUM: -3}_mysql.log"    && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootCyclosConfigurations.sh 2>&1       | tee "ini_${NUM: -3}_cyclos.log"   && CNT=$((  CNT += 1  ))  &&  NUM=000${CNT} 
   ./FirstBootCleanUp.sh			# Don't allow these scripts to be called ever again.
#

;;

*)
        echo "Usage: $0 {start}"
        exit 1
esac

