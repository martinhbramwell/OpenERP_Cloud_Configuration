#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
export JENKINS_USERZ_JOBS_DIR=/home/$JENKINS_USERZ_UID/jobs
#

# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain Syntevo SmartGit
SRV_SYNTEVO="http://www.syntevo.com"
#wget -cNb --output-file=dldJdk.log ${SRV_SYNTEVO}/download/smartgit/smartgit-generic-2_1_6.tar.gz
sudo rm -f dldSmartgit.log*
echo "Obtaining SmartGit.."
wget -cNb --output-file=dldSmartgit.log ${LOCAL_MIRROR}/smartgit-generic-2_1_6.tar.gz
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldSmartgit.log -p smartgit-generic
#
export SYNTEVO_HOME=${PRG}/com/syntevo
sudo mkdir -p ${SYNTEVO_HOME}
cd ${SYNTEVO_HOME}
echo "Expanding SmartGit.."
sudo tar zxvf ${INS}/smartgit-generic-2_1_6.tar.gz
echo "Symlinking SmartGit.."
sudo ln -s smartgit-2_1_6 smartgit
export SMARTGIT_HOME=${SYNTEVO_HOME}/smartgit
sudo chown -R yourself:yourself ${PRG}
#

