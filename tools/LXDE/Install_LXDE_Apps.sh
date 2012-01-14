#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
#
echo "Installing gedit ..."
sudo aptitude -y install gedit
echo " "
echo " gedit Installed  "
#
# Initiate downloading the installers we're going to need.
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
cd ${INS}
#
sudo rm -f dldLXDE_Tools.log*
echo "Obtaining LXDE Tools.."
# Obtain LXDE Tools
SRV_SOURCEFORGE="http://http://sourceforge.net/projects"
#wget -cNb --output-file=dldLXDE_Tools.log ${SRV_SOURCEFORGE}/lxde/files/latest/download?source=files
wget -cNb --output-file=dldLXDE_Tools.log ${LOCAL_MIRROR}/gpicview_0.1.8ubuntu1_i386.deb
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldLXDE_Tools.log -p gpicview_0.1.8
#
echo "Installing LXShortcut ..."
#
pwd 
#
echo "LXShortcut Installed..."



    
