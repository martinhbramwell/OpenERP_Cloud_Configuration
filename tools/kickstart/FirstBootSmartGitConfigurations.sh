#!/bin/sh
# 
sudo apt-get -y update
sudo apt-get -y upgrade
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
echo "Get SmartGit configurator"
#
# Obtain SmartGit Configurator script
cd ${PRG}/installTools/Syntevo
rm -f ./InstallSmartGit.sh
wget ${SRV_CONFIG}/tools/smartgit/InstallSmartGit.sh
chmod +x ./InstallSmartGit.sh
#
#
echo "Running SmartGit configurator now ..."
#
./InstallSmartGit.sh
#
echo "Completed SmartGit configurator"
