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
echo "Get SSH tools installer"
#
cd ${PRG}/installTools
# Obtain SSH tools installer script
rm -f ${PRG}/installTools/installSecureShellTools.sh
wget ${SRV_CONFIG}/tools/ssh/installSecureShellTools.sh
chmod +x ${PRG}/installTools/installSecureShellTools.sh
#
echo "Get SSH keygen tool"
#
# Obtain SSH tools installer script
rm -f ${PRG}/installTools/genSSH_key.sh
wget ${SRV_CONFIG}/tools/ssh/genSSH_key.sh
chmod +x ${PRG}/installTools/genSSH_key.sh
#
#
echo "Running SSH tools installer now ..."
#
${PRG}/installTools/installSecureShellTools.sh
