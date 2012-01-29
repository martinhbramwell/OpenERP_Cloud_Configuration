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
echo "Get Play Framework installer"
#
cd ${PRG}/installTools
# Obtain Play Framework installer script
rm -f ${PRG}/installTools/installPlayFramework.sh
wget ${SRV_CONFIG}/tools/playfwrk/installPlayFramework.sh
chmod +x ${PRG}/installTools/installPlayFramework.sh
#
#
echo "Running Play Framework installer now ..."
#
${PRG}/installTools/installPlayFramework.sh
