#! /bin/bash 
# script to get and install RunDeck complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export OUR_USERZ_UID=rundeck
export OUR_USERZ_HOME=/home/${OUR_USERZ_UID}
echo "Preparing RunDeck for ${OUR_USERZ_UID}."
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain RunDeck
SRV_RUNDECK="https://github.com/downloads/dtolabs/rundeck"

#wget -cNb --output-file=dldRunDeck.log ${SRV_RUNDECK}/rundeck-1.4.1-1.deb
sudo rm -f dldRunDeck.log*
echo "Obtaining RunDeck ..."
wget -cNb --output-file=dldRunDeck.log ${LOCAL_MIRROR}/rundeck-1.4.1-1.deb
#
echo "Clear any problem packages"
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
export PASS_HASH=$(perl -e 'print crypt($ARGV[0], "password")' "okokok")
echo ${PASS_HASH}
sudo useradd -Ds /bin/bash
sudo useradd -m -G admin,sudo -p ${PASS_HASH} ${OUR_USERZ_UID}
sudo passwd -e ${OUR_USERZ_UID}

echo "Make a place for the RSA key at $OUR_USERZ_HOME/.ssh ..."
#
sudo rm -fr $OUR_USERZ_HOME/.ssh/
#
sudo -u $OUR_USERZ_UID mkdir -p $OUR_USERZ_HOME/.ssh
sudo chmod 770 $OUR_USERZ_HOME/.ssh
#
echo "Make RSA key.."  ##   It'd be better to get it locally.  See below.
#
sudo -u ${OUR_USERZ_UID} ssh-keygen -N "aPassword" -t rsa -f $OUR_USERZ_HOME/.ssh/id_rsa
sudo chmod -R 660 $OUR_USERZ_HOME/.ssh/id_rsa
sudo chmod -R 660 $OUR_USERZ_HOME/.ssh/id_rsa.pub
# echo "Get RSA key from local file server."
# cd $OUR_USERZ_HOME/.ssh
# sudo -u $OUR_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/known_hosts
# sudo -u $OUR_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/id_rsa
# sudo -u $OUR_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/id_rsa.pub
# sudo -u $OUR_USERZ_UID chmod 600 id_rsa*
#
#
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldRunDeck.log -p rundeck
#
#

#
cd $OUR_USERZ_HOME
echo "export JAVA_HOME=/usr/lib/jvm/jdk" >> .bashrc 
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc 
echo "" >> .bashrc 
#
source .bash_profile
#
echo "Installing RunDeck where it wants to go ..."
sudo dpkg -i ${INS}/rundeck-1.4.1-1.deb
#
echo "Clear any problem packages"
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
exit 0;
