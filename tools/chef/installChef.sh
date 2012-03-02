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
export CHEF_USER=Chef
export CHEF_USERZ_UID=chef
export CHEF_GROUPZ_UID=${CHEF_USERZ_UID}
export CHEF_USERZ_HOME=/home/${CHEF_USERZ_UID}
# export CHEF_CONF_DIR=/etc/${CHEF_USERZ_UID}
# export CHEF_USERZ_WORK_DIR=/var/${CHEF_USERZ_UID}
# export CHEF_PROJECTZ_HOME=${CHEF_USERZ_WORK_DIR}/projects
# export GIT_MANAGED_CHEF_PROJECTS=${GIT_MANAGED_DIR}/projects
# export CHEF_QWIK_SCRIPTS=${ADMIN_USERZ_QWIK_SCRIPTS}/rd
export CHEF_USERZ_SSH_DIR=${CHEF_USERZ_HOME}/.ssh
echo "Preparing the ${CHEF_USER} server for user : ${CHEF_USERZ_UID}."
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
# Obtain Gems
SRV_GEMS="http://production.cf.rubygems.org/rubygems"
PATH_GEMS="rubygems-1.8.10"
INSTALLER_GEMS=${PATH_GEMS}".tgz"
LOGFILE_GEMS=dldGems.log

# wget -cNb --output-file=${LOGFILE_GEMS} ${SRV_GEMS}/${INSTALLER_GEMS}
sudo rm -f ${LOGFILE_GEMS}*
sudo rm -f ${INSTALLER_GEMS}*
echo "Obtaining Gems .........................................."
wget -cNb --output-file=${LOGFILE_GEMS} ${LOCAL_MIRROR}/${INSTALLER_GEMS}
sudo chown ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${INS}
#
echo "Create the ${CHEF_USERZ_UID} user..........."
export PASS_HASH=$(perl -e 'print crypt($ARGV[0], "password")' "okokok")
echo ${PASS_HASH}
sudo useradd -Ds /bin/bash
sudo useradd -m -G admin,sudo -d ${CHEF_USERZ_HOME} -p ${PASS_HASH} ${CHEF_USERZ_UID}
#
sudo chown -R ${CHEF_USERZ_UID}:${CHEF_USERZ_UID} ${CHEF_USERZ_HOME}
#
echo "Establish an SSH key pair for ${CHEF_USERZ_UID} ........"
#  Get one OR make one?
echo "Go get a key ..............................................."
sudo -u ${CHEF_USERZ_UID} mkdir -p ${CHEF_USERZ_SSH_DIR}
pushd ${CHEF_USERZ_SSH_DIR}
sudo rm -f kn*
sudo rm -f id_*
#
sudo -u ${CHEF_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${CHEF_USERZ_UID}/known_hosts
sudo -u ${CHEF_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${CHEF_USERZ_UID}/id_rsa.pub
sudo -u ${CHEF_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${CHEF_USERZ_UID}/id_rsa
sudo -u ${CHEF_USERZ_UID} chmod 600 id_rsa
popd
#
# echo "Generate a key ..........."
# sudo su - ${CHEF_USERZ_UID} -c "${PRG}/installTools/genSSH_key.sh"
#
#
echo "Terminate the password of ${CHEF_USERZ_UID} ................"
sudo passwd -e ${CHEF_USERZ_UID}
#
echo "Clear any problem packages.................................."
sudo aptitude -y update
sudo aptitude -y upgrade
#
echo "Get ${CHEF_USER} dependencies . . . . . . . . . . . . . . . "
sudo aptitude -y install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert git-core
#
sudo aptitude -fy install
#
echo "Configure git for first time use . . . . . . . . . . . . . ."
sudo -Hu ${CHEF_USERZ_UID} git config --global user.email "martinhbramwell@yahoo.com"
sudo -Hu ${CHEF_USERZ_UID} git config --global user.name "Hasan"

#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./${LOGFILE_GEMS} -p rubygems
#
echo "Install Ruby Gems . . . . . . . . . . . . . . . . . . . . . "
sudo mkdir -p ${PRG}/org
cd ${PRG}/org
#
tar zxf ${INS}/${INSTALLER_GEMS}
cd ./${PATH_GEMS}
sudo ruby setup.rb --no-format-executable
#
echo "Which gem version did we get . . . . . . . . . . . . . . . "
gem -v
#
# -----------------------------------------------------------
#
echo "Ready to install ${CHEF_USER} . . . . . . . . . . . . . . . "
#
sudo gem install chef
#
echo "How does it look? . . . . . . . . . . . . . . . . . . . . . "
chef-client -v
#
#
echo "Get all the other files from GitHub . . . . . . . . . . . . "
sudo rm -fr ${CHEF_USERZ_HOME}/chef-repo
cd ${CHEF_USERZ_HOME}
pwd
sudo -Hu ${CHEF_USERZ_UID} git clone https://github.com/opscode/chef-repo.git
#
echo "Prepare an authentication keys directory for ${CHEF_USER} Hosting . "
sudo -Hu ${CHEF_USERZ_UID} mkdir -p ${CHEF_USERZ_HOME}/chef-repo/.chef
cd ${CHEF_USERZ_HOME}/chef-repo/.chef
sudo rm *.rb*
sudo rm *.pem*
#
sudo -Hu ${CHEF_USERZ_UID} wget ${LOCAL_MIRROR}/chef/knife.rb
sudo -Hu ${CHEF_USERZ_UID} wget ${LOCAL_MIRROR}/chef/hasanb.pem
sudo -Hu ${CHEF_USERZ_UID} wget ${LOCAL_MIRROR}/chef/fltgclds-validator.pem 
#
#
echo "Are we able to connect . . . .  . . . .  . . . .  . . . . . "
cd ..
sudo -Hu ${CHEF_USERZ_UID} knife client list
#
#
echo "Clear any problem packages ................................."
sudo aptitude -y update
sudo aptitude -y upgrade
sudo aptitude -fy install
#
#
exit;


