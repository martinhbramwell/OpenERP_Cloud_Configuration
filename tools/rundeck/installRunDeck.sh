#! /bin/bash 
# script to get and install RunDeck complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p ${ADMIN_USERZ_WORK_DIR}
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export OUR_USERZ_UID=rundeck
export OUR_USERZ_HOME=/var/lib/${OUR_USERZ_UID}
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
echo "Clear any problem packages.............."
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
echo "Create the ${OUR_USERZ_UID} user..........."
export PASS_HASH=$(perl -e 'print crypt($ARGV[0], "password")' "okokok")
echo ${PASS_HASH}
sudo useradd -Ds /bin/bash
sudo useradd -m -G admin,sudo -d ${OUR_USERZ_HOME} -p ${PASS_HASH} ${OUR_USERZ_UID}
#
sudo chown -R ${OUR_USERZ_UID}:${OUR_USERZ_UID} ${OUR_USERZ_HOME}
#
echo "Generate a key..........."
sudo su - ${OUR_USERZ_UID} -c "${PRG}/installTools/genSSH_key.sh"
#
echo "Terminate the password of ${OUR_USERZ_UID} ..........."
sudo passwd -e ${OUR_USERZ_UID}
#
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldRunDeck.log -p rundeck
#
cd ${OUR_USERZ_HOME}
echo "export JAVA_HOME=/usr/lib/jvm/jdk" >> .bashrc 
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc 
echo "" >> .bashrc 
#
source .bash_profile
#
echo "Installing RunDeck where it wants to go ..."
sudo dpkg -i ${INS}/rundeck-1.4.1-1.deb
#
sudo chown -R ${OUR_USERZ_UID}:${OUR_USERZ_UID} ${OUR_USERZ_HOME}
#
echo "Clear any problem packages"
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
exit 0;
