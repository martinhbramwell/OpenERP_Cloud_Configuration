#!/bin/bash
# Starts simple test
#
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
echo "Complete the installation with all updates & upgrades"
sudo apt-get -y update
sudo apt-get -y upgrade
#
echo "Temporarily set some environment variables pertinent only for the currently executing scripts."
#
cd $ADMIN_USERZ_HOME/
echo "if [ -f ./.bashrc ]; then"  >> .bash_profile
echo "   source ./.bashrc"  >> .bash_profile
echo "fi"  >> .bash_profile
#
echo "#"  >> .bashrc
echo "export SRV_CONFIG=${SRV_CONFIG}"  >> .bashrc
#
# Now make them available immediately
source .bash_profile
#
echo "Ensure JAVA_HOME can be detected by root !"
# Create a sudoers extension file and authorize passing JAVA_HOME & M2_HOME into new environment
cd $ADMIN_USERZ_WORK_DIR/
rm -f neededBy* 
echo 'Defaults env_keep+="JAVA_HOME M2_HOME CATALINA_HOME TOMCAT_USER"' > neededByTomCat
chmod 0440 neededByTomCat 
sudo chown root:root neededByTomCat 
sudo mv neededByTomCat /etc/sudoers.d/
# vi visudo
# #   Defaults:yourself timestamp_timeout=-1
#
#
echo "Prepare some variables for later use. [$SRV_CONFIG]"
#
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
export FAILURE_NOTICE="______Looks_like_it_failed______"
#
cd $ADMIN_USERZ_HOME/
# Make a place to keep installers "just in case..."
mkdir -p $ADMIN_USERZ_HOME/installers
echo export "INS=$INS" >> .bash_aliases
#
# Make a place to keep programs
mkdir -p $ADMIN_USERZ_HOME/programs
echo "export PRG=$PRG" >> .bash_aliases
#
# A test result variable
echo "export FAILURE_NOTICE=$FAILURE_NOTICE" >> .bash_aliases
#
# Make them available permanently
source .bashrc
#
echo "Obtain remotely customized environment variables."
# Prepare
cd $ADMIN_USERZ_HOME/programs
# Get the master files of environment variables
rm -f ./ConfigRequiredVars.sh*
wget ${SRV_CONFIG}/tools/ConfigRequiredVars.sh
chmod +x ./ConfigRequiredVars.sh
#
rm -f ./MavenRequiredVars.sh*
wget ${SRV_CONFIG}/tools/MavenRequiredVars.sh
chmod +x ./MavenRequiredVars.sh
#
rm -f ./TomcatRequiredVars.sh*
wget ${SRV_CONFIG}/tools/TomcatRequiredVars.sh
chmod +x ./TomcatRequiredVars.sh
#
rm -f ./JenkinsRequiredVars.sh*
wget ${SRV_CONFIG}/tools/JenkinsRequiredVars.sh
chmod +x ./JenkinsRequiredVars.sh
#
rm -f ./MakeEnvironment.sh*
wget ${SRV_CONFIG}/tools/MakeEnvironment.sh
chmod +x ./MakeEnvironment.sh
#
#
#
echo "Generate a new environment file"
# Generate a new environment
source $ADMIN_USERZ_HOME/programs/ConfigRequiredVars.sh
source $ADMIN_USERZ_HOME/programs/MavenRequiredVars.sh
source $ADMIN_USERZ_HOME/programs/TomcatRequiredVars.sh
source $ADMIN_USERZ_HOME/programs/JenkinsRequiredVars.sh
#
# Prepare
mkdir -p $ADMIN_USERZ_WORK_DIR
cd $ADMIN_USERZ_WORK_DIR
#
# Generate a new environment file
$ADMIN_USERZ_HOME/programs/MakeEnvironment.sh
#
# Make the variables available immediately
source environment
#
#  Give over to root's ownership
sudo chown root:root environment
#
# Make the variables available permanently
sudo mv environment /etc/
#
# Clean up
rm -fr $ADMIN_USERZ_WORK_DIR
#
#
echo "Networking"
echo "Set up static addressing with these steps :"
# Define new settings
vFixMe=continuous
vFixMe1=192.168.122
vFixMe2=3
#
# Make a place to work
mkdir -p $ADMIN_USERZ_WORK_DIR/etc/network
cd $ADMIN_USERZ_WORK_DIR
#
# Get the fresh files
wget ${SRV_CONFIG}/etc/resolv.conf
wget ${SRV_CONFIG}/etc/hosts_FixMe
wget ${SRV_CONFIG}/etc/hostname_FixMe
wget ${SRV_CONFIG}/etc/network/interfaces_FixMe
#
# Make the changes
mv resolv.conf ./etc
sed s/FixMe/$vFixMe/ <hostname_FixMe >./etc/hostname
sed s/FixMe/$vFixMe/ <hosts_FixMe >./etc/hosts
sed s/FixMe1/$vFixMe1/ <interfaces_FixMe >tmp
sed s/FixMe2/$vFixMe2/ <tmp >./etc/network/interfaces
#
#
echo "=======   Overwrite existing networking definitions  ======="
echo "============================================================"
sudo cp -R ./etc/* /etc
# sudo ifdown eth0; sudo ifup eth0
#

