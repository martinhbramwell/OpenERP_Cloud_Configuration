#!/bin/bash
# 
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -fy install
#
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
#
export FAILURE_NOTICE="______Looks_like_it_failed______"
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
echo "Get Chef configurator"
#
# Obtain Chef Configurator script
cd ${PRG}/installTools
rm -f ./installChef.sh
wget ${SRV_CONFIG}/tools/chef/installChef.sh
chmod +x ./installChef.sh
#
#
echo "Running Chef configurator now ..."
#
./installChef.sh
#
echo "Completed Chef configurator"

