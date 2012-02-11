#! /bin/bash 
# script to get and install RunDeck complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_DEV_DIR=/home/${ADMIN_USERZ_UID}/dev
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p ${ADMIN_USERZ_WORK_DIR}
#
export GIT_MANAGED_PROJECT=RunDeckToolSet
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
#
export GIT_SOURCE=git@github.com:martinhbramwell
export MASTER_PROJECT=${GIT_SOURCE}/${GIT_MANAGED_PROJECT}.git
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export RUNDECK_USER=RunDeck
export RUNDECK_USERZ_UID=rundeck
export RUNDECK_GROUPZ_UID=${RUNDECK_USERZ_UID}
export RUNDECK_USERZ_HOME=/var/lib/${RUNDECK_USERZ_UID}
export RUNDECK_USERZ_SSH_DIR=${RUNDECK_USERZ_HOME}/.ssh
echo "Preparing the RunDeck server for user : ${RUNDECK_USERZ_UID}."
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
sudo aptitude -y install java6-runtime
sudo aptitude -fy install
#
echo "Create the ${RUNDECK_USERZ_UID} user..........."
export PASS_HASH=$(perl -e 'print crypt($ARGV[0], "password")' "okokok")
echo ${PASS_HASH}
sudo useradd -Ds /bin/bash
sudo useradd -m -G admin,sudo -d ${RUNDECK_USERZ_HOME} -p ${PASS_HASH} ${RUNDECK_USERZ_UID}
#
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${RUNDECK_USERZ_HOME}
#
echo "Establish an SSH key pair for  ........"
#  Get one OR make one?
echo "Go get a key ..........."
sudo -u $RUNDECK_USERZ_UID mkdir -p ${RUNDECK_USERZ_SSH_DIR}
pushd ${RUNDECK_USERZ_SSH_DIR}
sudo -u $RUNDECK_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/$RUNDECK_USERZ_UID/known_hosts
sudo -u $RUNDECK_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/$RUNDECK_USERZ_UID/id_rsa
sudo -u $RUNDECK_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/$RUNDECK_USERZ_UID/id_rsa.pub
popd
#
# echo "Generate a key ..........."
# sudo su - ${RUNDECK_USERZ_UID} -c "${PRG}/installTools/genSSH_key.sh"
#
#
echo "Terminate the password of ${RUNDECK_USERZ_UID} ..........."
sudo passwd -e ${RUNDECK_USERZ_UID}
#
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldRunDeck.log -p rundeck
#
cd ${RUNDECK_USERZ_HOME}
echo "export JAVA_HOME=/usr/lib/jvm/jdk" >> .bashrc 
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc 
echo "" >> .bashrc 
#
source .bash_profile
#
echo "Installing RunDeck where it wants to go ..."
sudo dpkg -i ${INS}/rundeck-1.4.1-1.deb
#
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${RUNDECK_USERZ_HOME}
#
echo "Obtain our RunDeck projects .............."

#
echo "Prepare a Git Repo to contain the ${RUNDECK_USER} Project : "
#
mkdir -p ${ADMIN_USERZ_DEV_DIR}
cd ${ADMIN_USERZ_DEV_DIR}
rm -fr ${GIT_MANAGED_PROJECT} 
#
mkdir -p ${GIT_MANAGED_DIR}
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${GIT_MANAGED_DIR}
#
echo "Clone the whole Cloud project into the Git managed directory :"
echo "The next step requires tight security so use 600 ...."
sudo -Hu ${RUNDECK_USERZ_UID} chmod 600 ${RUNDECK_USERZ_SSH_DIR}/*
echo sudo -Hu ${RUNDECK_USERZ_UID} git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
sudo -Hu $RUNDECK_USERZ_UID git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
echo "Undo tight security so ${RUNDECK_USER} & SmartGit can share the key"
sudo -Hu ${RUNDECK_USERZ_UID} chmod 660 ${RUNDECK_USERZ_SSH_DIR}/*
echo "${RUNDECK_USER} needs to own the whole hierarchy ..."
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${GIT_MANAGED_PROJECT}
#
echo "But SmartGit needs read & write privileges ..."
sudo usermod -a -G ${RUNDECK_GROUPZ_UID} ${ADMIN_USERZ_UID}
chmod -R g+rw ${GIT_MANAGED_DIR}
#
#
#
echo "Clear any problem packages ..............."
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
exit 0;
