#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
#
# Initiate downloading the installers we're going to need.
cd ${INS}
#
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
#
echo "Get RSA key generator dependencies ..."
sudo aptitude -y install ssh-askpass
sudo aptitude -y update
sudo aptitude -y upgrade
#
echo "Ensure both $JENKINS_USERZ_UID user and $ADMIN_USERZ_UID can access RSA key.."
sudo usermod -a -G $JENKINS_USERZ_UID $ADMIN_USERZ_UID
#
echo "Make a place for the RSA key at $JENKINS_USERZ_HOME/.ssh ..."
#
sudo rm -fr $JENKINS_USERZ_HOME/.ssh
#
sudo -u $JENKINS_USERZ_UID mkdir -p $JENKINS_USERZ_HOME/.ssh
sudo chmod 770 $JENKINS_USERZ_HOME/.ssh
#
echo "Make RSA key.."
#
sudo -u jenkins ssh-keygen -N "okokok" -t rsa -f $JENKINS_USERZ_HOME/.ssh/id_rsa
sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa
sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa.pub
#
#
echo "Creating panel button.."
#
cd ${PRG}/installTools
pwd
#
wget -cN ${SRV_CONFIG}/tools/InsertInFile.sh
chmod +x ./InsertInFile.sh
ls -l
#
#
PANEL_CONFIG=${ADMIN_USERZ_HOME}/.config/lxpanel/LXDE/panels
# TOP_PANEL_CONFIG=${ADMIN_USERZ_HOME}/.config/lxpanel/LXDE/panels/top
cd ${ADMIN_USERZ_WORK_DIR}
pwd
#
LAUNCHER=smartgit.desktop
APPLICATIONS=/usr/share/applications
#
wget -cN ${SRV_CONFIG}/tools/smartgit/$LAUNCHER
sudo chown root:root $LAUNCHER
sudo chmod 644 $LAUNCHER
echo sudo mv $LAUNCHER $APPLICATIONS
sudo mv $LAUNCHER $APPLICATIONS
#
cp $PANEL_CONFIG/top .
#
INSERTION="    Button \{\n            id=$APPLICATIONS/$LAUNCHER\n        }\n    "
EOF_MARKER="\}"
FILE=top
${PRG}/installTools/InsertInFile.sh -i "${INSERTION}" -s "${EOF_MARKER}" -f ${FILE}

sudo chown -R $ADMIN_USERZ_UID:$ADMIN_USERZ_UID ${ADMIN_USERZ_HOME}
mv top top.bk
#
mv -f ./top.new $PANEL_CONFIG/top
#
# tail -n 25  $PANEL_CONFIG/top
# ls -l
# ls -l $APPLICATIONS/sma*
# exit 0;

