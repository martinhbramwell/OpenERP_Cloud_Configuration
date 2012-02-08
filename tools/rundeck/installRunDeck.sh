#! /bin/bash 
# script to go and get RunDeck complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain RunDeck
SRV_CYCLOS="https://github.com/downloads/dtolabs/rundeck"

#wget -cNb --output-file=dldRunDeck.log ${SRV_CYCLOS}/rundeck-1.4.1-1.deb
sudo rm -f dldRunDeck.log*
echo "Obtaining RunDeck ..."
wget -cNb --output-file=dldRunDeck.log ${LOCAL_MIRROR}/rundeck-1.4.1-1.deb
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldRunDeck.log -p rundeck
#
#
# 
cd ${PRG}/org
pwd
echo "Expanding RunDeck ..."
sudo unzip -f ${INS}/rundeck-1.4.1-1.deb
echo "Preparing RunDeck ..."
sudo ln -s cyclos_3.6 cyclos
#
export CYCLOS_HOME=${PRG}/org/cyclos
sudo chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${ADMIN_USERZ_HOME}
#
echo "Fiddling TomCat for RunDeck ..."
#
exit 0;
