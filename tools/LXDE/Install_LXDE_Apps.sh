#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
sudo rm -f dldLXDE_Tools.log*
echo "Obtaining LXDE Tools.."
# Obtain LXDE Tools
SRV_SOURCEFORGE="http://http://sourceforge.net/projects"
#wget -cNb --output-file=dldJdk.log ${SRV_SOURCEFORGE}/lxde/files/latest/download?source=files
wget -cNb --output-file=dldLXDE_Tools.log ${LOCAL_MIRROR}/gpicview_0.1.8ubuntu1_i386.deb
#
echo "Installing LXShortcut ..."



    
