#!/bin/sh
# 
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
sudo mkdir -p $ADMIN_USERZ_WORK_DIR
sudo mkdir -p ${PRG}/installTools
#
echo "Get Apache Ant installer"
#
cd ${PRG}/installTools
# Obtain Apache Ant installer script
rm -f ${PRG}/installTools/installApacheAntTools
wget ${SRV_CONFIG}/tools/ssh/installApacheAntTools
chmod +x ${PRG}/installTools/installApacheAntTools
#
#
echo "Running Apache Ant installer now ..."
#
${PRG}/installTools/installApacheAntTools
