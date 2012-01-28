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
if [ ! -f ${PRG}/installTools/waitForLogFileEvent.sh ]
then
	echo "Need to get waitForLogFileEvent.sh."
	cd ${PRG}/installTools
	rm -f ${PRG}/installTools/waitForLogFileEvent.sh
	wget ${SRV_CONFIG}/tools/waitForLogFileEvent.sh
	chmod +x ${PRG}/installTools/waitForLogFileEvent.sh
fi
#
echo "Now we can get Ant from local file server."
cd ${INS}
#
SRV_APACHE_ANT="http://ftp.wayne.edu/apache/ant/"
#wget -cNb --output-file=dldJdk.log ${SRV_APACHE_ANT}/binaries/apache-ant-1.8.2-bin.tar.gz
sudo rm -f dldApacheAnt.log*
echo "Obtaining Apache Ant ..."
wget -cNb --output-file=dldApacheAnt.log ${LOCAL_MIRROR}/apache-ant-1.8.2-bin.tar.gz
#
#
echo "Wait for Ant to arrive ..."
SEARCH_PATTERN="apache-ant[_0-9A-Za-z'\.\-]* saved"
FAILURE_PATTERN="nothing to do|ERROR"
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldApacheAnt.log -s "${SEARCH_PATTERN}" -f "${FAILURE_PATTERN}"
#
# Decompress it into /usr/share
cd $DEFAULT_APPLICATIONS_DIR
sudo tar -zxvf ${INS}/apache-ant-1.8.2-bin.tar.gz
#
# Make a permanent name for it
sudo rm -f ant
sudo ln -s ./apache-ant-1.8.2/ ant
#
# And a local environment variable
export ANT_HOME=/usr/share/ant
#
sudo cp /etc/environment envtmp
sudo sed -i "/JAVA_HOME=/aANT_HOME=${ANT_HOME}" envtmp
sudo sed -i "/^PATH=/ s/\$/:\$ANT_HOME\/bin/" envtmp
sudo mv envtmp /etc/environment
#
export PATH=$PATH:$ANT_HOME/bin
echo "Check it works...$PATH "
ant -version








