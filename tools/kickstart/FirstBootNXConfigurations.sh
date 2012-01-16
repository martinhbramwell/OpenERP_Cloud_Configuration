#!/bin/sh
# 
sudo apt-get -y update
sudo apt-get -y upgrade
#
sudo apt-get -y install gedit
#
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
export FAILURE_NOTICE="______Looks_like_it_failed______"
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
echo "Get NX installers"
#
# Obtain NX installer script
cd ${PRG}/installTools
rm -f ./Install_NX_Apps.sh
wget ${SRV_CONFIG}/tools/NX/Install_NX_Apps.sh
chmod +x ./Install_NX_Apps.sh
#
#
echo "Running NX installer now ..."
#
./Install_NX_Apps.sh
