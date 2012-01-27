#!/bin/bash
# Script to install Apache Ant.
#
export LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_UID_UC=Jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export DEFAULT_APPLICATIONS_DIR=/usr/share
#
# Prerequisite : waitForLogFileEvent.sh * * * 
#
rm -f ${PRG}/installTools/waitForLogFileEvent.sh
wget ${SRV_CONFIG}/tools/waitForLogFileEvent.sh
chmod +x ${PRG}/installTools/waitForLogFileEvent.sh
#
echo "Get Ant from local file server."
cd ${INS}
#
SRV_APACHE_ANT="http://ftp.wayne.edu/apache/ant/"
#wget -cNb --output-file=dldJdk.log ${SRV_APACHE_ANT}/binaries/apache-ant-1.8.2-bin.tar.gz
sudo rm -f dldApacheAnt.log*
echo "Obtaining SmartGit.."
wget -cNb --output-file=dldApacheAnt.log ${LOCAL_MIRROR}/apache-ant-1.8.2-bin.tar.gz
#
#
echo "Wait for Ant to arrive ..."
SEARCH_PATTERN="apache-ant' saved"
FAILURE_PATTERN="nothing to do|ERROR"
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldApacheAnt.log -s "${SEARCH_PATTERN}" -f "${FAILURE_PATTERN}"
#
# Decompress it into /usr/share
cd $DEFAULT_APPLICATIONS_DIR
sudo tar -zxvf ${INS}/apache-ant-1.8.2-bin.tar.gz
#
# Make a permanent name for it
sudo ln -s ./apache-ant-1.8.2/ ant
#
# And a local environment variable
export ANT_HOME=/usr/share/ant
#
echo "Check it works..."
sudo -Hu jenkins ssh -T git@github.com
#
echo "Permit SmartGit access too."
sudo -u $JENKINS_USERZ_UID chmod 660 id_rsa*
ls -la 







