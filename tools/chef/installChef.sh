#! /bin/bash 
# script to get and install Chef complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_QWIK_SCRIPTS=${ADMIN_USERZ_HOME}/q
export ADMIN_USERZ_DEV_DIR=/home/${ADMIN_USERZ_UID}/dev
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p ${ADMIN_USERZ_WORK_DIR}
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
export GIT_MANAGED_PROJECT=ChefToolSet
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
#
export GIT_SOURCE=git@github.com:FleetingClouds
export MASTER_PROJECT=${GIT_SOURCE}/${GIT_MANAGED_PROJECT}.git
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export RUNDECK_USER=Chef
export RUNDECK_USERZ_UID=chef
export RUNDECK_GROUPZ_UID=${RUNDECK_USERZ_UID}
export RUNDECK_USERZ_HOME=/var/lib/${RUNDECK_USERZ_UID}
export RUNDECK_CONF_DIR=/etc/${RUNDECK_USERZ_UID}
export RUNDECK_USERZ_WORK_DIR=/var/${RUNDECK_USERZ_UID}
export RUNDECK_PROJECTZ_HOME=${RUNDECK_USERZ_WORK_DIR}/projects
export GIT_MANAGED_RUNDECK_PROJECTS=${GIT_MANAGED_DIR}/projects
export RUNDECK_QWIK_SCRIPTS=${ADMIN_USERZ_QWIK_SCRIPTS}/rd
export RUNDECK_USERZ_SSH_DIR=${RUNDECK_USERZ_HOME}/.ssh
echo "Preparing the Chef server for user : ${RUNDECK_USERZ_UID}."
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain Chef
SRV_RUNDECK="https://github.com/downloads/dtolabs/chef"

# wget -cNb --output-file=dldChef.log ${SRV_RUNDECK}/chef-1.4.2-1.deb
# mv chef-1.4.2-1.deb chef.deb
sudo rm -f dldChef.log*
echo "Obtaining Chef .........................................."
wget -cNb --output-file=dldChef.log ${LOCAL_MIRROR}/chef.deb
#
echo "Clear any problem packages.................................."
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
echo "Establish an SSH key pair for ${RUNDECK_USERZ_UID} ........"
#  Get one OR make one?
echo "Go get a key ..............................................."
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
echo "Terminate the password of ${RUNDECK_USERZ_UID} ............."
sudo passwd -e ${RUNDECK_USERZ_UID}
#
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldChef.log -p chef
#
export JAVA_HOME=/usr/lib/jvm/jdk
export PATH=$PATH:$JAVA_HOME/bin
#
echo "Installing Chef where it wants to go ...................."
sudo dpkg -i ${INS}/chef.deb
#
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${RUNDECK_USERZ_HOME}
#
echo "Obtain our Chef projects ................................"

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
echo "The next step requires tight security so use 600 ..........."
sudo -Hu ${RUNDECK_USERZ_UID} chmod 600 ${RUNDECK_USERZ_SSH_DIR}/*
echo sudo -Hu ${RUNDECK_USERZ_UID} git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
sudo -Hu ${RUNDECK_USERZ_UID} git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
sudo -Hu ${RUNDECK_USERZ_UID} mkdir -p ${GIT_MANAGED_RUNDECK_PROJECTS} # Just in case there are no projects yet.
### echo "Undo tight security so ${RUNDECK_USER} & SmartGit can share the key"
### sudo -Hu ${RUNDECK_USERZ_UID} chmod 660 ${RUNDECK_USERZ_SSH_DIR}/*
echo "${RUNDECK_USER} needs to own the whole hierarchy ..........."
sudo chown -R ${RUNDECK_USERZ_UID}:${RUNDECK_USERZ_UID} ${GIT_MANAGED_PROJECT}
#
echo "But SmartGit needs read & write privileges ..."
sudo -Hu ${RUNDECK_USERZ_UID} rm -fr ${RUNDECK_PROJECTZ_HOME}
sudo -Hu ${RUNDECK_USERZ_UID} ln -s ${GIT_MANAGED_RUNDECK_PROJECTS} ${RUNDECK_PROJECTZ_HOME}
#
sudo usermod -a -G ${RUNDECK_GROUPZ_UID} ${ADMIN_USERZ_UID}
chmod -R g+rw ${GIT_MANAGED_DIR}
chmod -R g+rw ${RUNDECK_USERZ_WORK_DIR}
#
echo "Get Chef backup and restore scripts  ...................."
sudo mkdir -p ${RUNDECK_QWIK_SCRIPTS}
pushd ${RUNDECK_QWIK_SCRIPTS}
#
rm -f ./BackupChefProjects.sh
wget ${SRV_CONFIG}/tools/chef/BackupChefProjects.sh
chmod +x ./BackupChefProjects.sh
ln -s ./BackupChefProjects.sh bkp
#
rm -f ./RestoreChefProjects.sh
wget ${SRV_CONFIG}/tools/chef/RestoreChefProjects.sh
chmod +x ./RestoreChefProjects.sh
ln -s ./RestoreChefProjects.sh rst
popd
#
echo "Fix configuration defect ..................................."
pushd ${RUNDECK_CONF_DIR}
cp apitoken.aclpolicy apitoken.aclpolicy.old
sed 's|,kill] # allow read/write|,create,kill] # allow create/read/write|' <apitoken.aclpolicy.old >apitoken.aclpolicy
popd
#
echo "Append required environment variables ......................"
export TARGET_FILE=/etc/environment
export NEW_VARIABLE_NAME=RUNDECK_PROJECTS
export NEW_VARIABLE_VALUE=/var/chef/projects
grep -q ${NEW_VARIABLE_NAME} ${TARGET_FILE} || echo ${NEW_VARIABLE_NAME}=${NEW_VARIABLE_VALUE}  | sudo tee -a ${TARGET_FILE}
#
echo "Now start up chef ......................................"
sudo /etc/init.d/rundeckd start
#
#
echo "Clear any problem packages ................................."
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
exit 0;


