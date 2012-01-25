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
mkdir -p $ADMIN_USERZ_WORK_DIR
#
echo "Get SSH tools installer"
#
# Obtain SSH tools installer script
cd ${PRG}/installTools
rm -f ./installSecureShellTools.sh
wget ${SRV_CONFIG}/tools/SSH/installSecureShellTools.sh
chmod +x ./installSecureShellTools.sh
#
#
echo "Running SSH tools installer now ..."
#
./installSecureShellTools.sh
