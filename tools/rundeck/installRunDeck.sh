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
echo "Installing RunDeck where it wants to go ..."
sudo dpkg -i ${INS}/rundeck-1.4.1-1.deb
#
export OUR_USER="rundeck"
echo "Preparing RunDeck for ${OUR_USER}."
#
export PASS_HASH=$(perl -e 'print crypt($ARGV[0], "password")' "okokok")
echo ${PASS_HASH}
sudo useradd -Ds /bin/bash
sudo useradd -m -G admin,sudo -p ${PASS_HASH} ${OUR_USER}
sudo passwd -e ${OUR_USER}
#
exit 0;
