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
echo "Get Fitnesse Wiki installer"
#
cd ${PRG}/installTools
# Obtain Fitnesse Wiki installer script
rm -f ${PRG}/installTools/installFitnesseWiki.sh
wget ${SRV_CONFIG}/tools/fitwiki/installFitnesseWiki.sh
chmod +x ${PRG}/installTools/installFitnesseWiki.sh
#
#
echo "Running Fitnesse Wiki installer now ..."
#
${PRG}/installTools/installFitnesseWiki.sh
