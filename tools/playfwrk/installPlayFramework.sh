#!/bin/bash
# Script to install Play Framework.
#
export LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
#
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export DEFAULT_APPLICATIONS_DIR=/usr/share
export PLAY_VERSION=1.2.4
#
# Prerequisite : waiForLogFileEvent.sh * * * 
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
echo "Now we can get Play Framework from local file server."
cd ${INS}
#
SRV_PLAY_FRMWRK="http://download.playframework.org/releases/"
#wget -cNb --output-file=dldJdk.log ${SRV_PLAY_FRMWRK}/play-${PLAY_VERSION}.zip
sudo rm -f dldPlayFrmwrk.log*
echo "Obtaining Play Framework ..."
wget -cNb --output-file=dldPlayFrmwrk.log ${LOCAL_MIRROR}/play-${PLAY_VERSION}.zip
#
#
echo "Wait for Play Framework to arrive ..."
SEARCH_PATTERN="play[_0-9A-Za-z'\.\-]*zip' saved"
FAILURE_PATTERN="nothing to do|ERROR"
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldPlayFrmwrk.log -s "${SEARCH_PATTERN}" -f "${FAILURE_PATTERN}"
#
# Decompress it into /usr/share
cd $DEFAULT_APPLICATIONS_DIR
sudo unzip ${INS}/play-${PLAY_VERSION}.zip
#
# Make a permanent name for it
sudo rm -f play
sudo ln -s ./play-${PLAY_VERSION}/ play
#
# And a local environment variable
export PLAY_HOME=/usr/share/play
#
sudo cp /etc/environment envtmp
sudo sed -i "/JAVA_HOME=/aPLAY_HOME=${PLAY_HOME}" envtmp
sudo sed -i "/^PATH=/ s/\$/:\/usr\/share\/play/" envtmp
sudo mv envtmp /etc/environment
#
export PATH=$PATH:$PLAY_HOME
echo "Check it works...$PATH "








