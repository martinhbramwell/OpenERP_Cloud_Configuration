#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
export ADMIN_USERZ_DEV_DIR=/home/$ADMIN_USERZ_UID/dev
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
#
export SMARTGIT_CONFIG_DIR=$ADMIN_USERZ_HOME/.smartgit
export SMARTGIT_CONFIG_URI=/tools/smartgit
export SMARTGIT_VERSION=2.1
#
# Initiate downloading the installers we're going to need.
cd ${INS}
#
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain Syntevo SmartGit
SRV_SYNTEVO="http://www.syntevo.com"
#wget -cNb --output-file=dldJdk.log ${SRV_SYNTEVO}/download/smartgit/smartgit-generic-2_1_7.tar.gz
sudo rm -f dldSmartgit.log*
echo "Obtaining SmartGit.."
wget -cNb --output-file=dldSmartgit.log ${LOCAL_MIRROR}/smartgit-generic-2_1_7.tar.gz
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldSmartgit.log -p smartgit-generic
#
export SYNTEVO_HOME=${PRG}/com/syntevo
sudo mkdir -p ${SYNTEVO_HOME}
cd ${SYNTEVO_HOME}
echo "Expanding SmartGit.."
sudo tar zxvf ${INS}/smartgit-generic-2_1_7.tar.gz
echo "Symlinking SmartGit.."
sudo ln -s smartgit-2_1_7 smartgit
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
if [  0 == 1  ]
then
	echo "Make a place for the RSA key at $JENKINS_USERZ_HOME/.ssh ..."
	#
	sudo rm -fr $JENKINS_USERZ_HOME/.ssh
	#
	sudo -u $JENKINS_USERZ_UID mkdir -p $JENKINS_USERZ_HOME/.ssh
	sudo chmod 770 $JENKINS_USERZ_HOME/.ssh
	#
	#     echo "Make RSA key.."  ##   Better to get it locally.  See below.
	#
	#     sudo -u jenkins ssh-keygen -N "okokok" -t rsa -f $JENKINS_USERZ_HOME/.ssh/id_rsa
	#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa
	#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa.pub
	echo "Get RSA key from local file server."
	$JENKINS_USERZ_HOME/.ssh
	sudo wget -cN ${LOCAL_MIRROR}/id_rsa
	sudo wget -cN ${LOCAL_MIRROR}/id_rsa.pub
	#
fi
echo "Provide initial settings files."
sudo mkdir -p $SMARTGIT_CONFIG_DIR/${SMARTGIT_VERSION}
sudo chown -R $ADMIN_USERZ_UID:$ADMIN_USERZ_UID $SMARTGIT_CONFIG_DIR
cd $SMARTGIT_CONFIG_DIR/${SMARTGIT_VERSION}
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/settings.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/accelerators.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/credentials.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/hostingProviders.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/projects.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/settings.xml
wget -cN ${SRV_CONFIG}${SMARTGIT_CONFIG_URI}/${SMARTGIT_VERSION}/uiSettings.xml
#
cd ${ADMIN_USERZ_HOME}
echo "export JAVA_HOME=/usr/lib/jvm/jdk" >> .bashrc 
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> .bashrc 
echo "" >> .bashrc 
#
echo "if [ -f ./.bashrc ]; then" > .bash_profile
echo "   source ./.bashrc" >> .bash_profile
echo "fi" >> .bash_profile
echo "" >> .bash_profile
#
source .bash_profile
#
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
echo "Create app launcher..."
LAUNCHER=smartgit.desktop
APPLICATIONS=/usr/share/applications
#
wget -cN ${SRV_CONFIG}/tools/smartgit/$LAUNCHER
sudo chown root:root $LAUNCHER
sudo chmod 644 $LAUNCHER
echo sudo mv $LAUNCHER $APPLICATIONS
sudo mv $LAUNCHER $APPLICATIONS
#
echo "Edit top panel configuration"
cp $PANEL_CONFIG/top .
#
INSERTION="    Button \{\n            id=$APPLICATIONS/$LAUNCHER\n        }\n    "
EOF_MARKER="\}"
FILE=top
${PRG}/installTools/InsertInFile.sh -i "${INSERTION}" -s "${EOF_MARKER}" -f ${FILE}

mv top top.bk
#
mv -f ./top.new $PANEL_CONFIG/top
#
echo "Set ownership conditions"
#
export GIT_MANAGED_PROJECT=OpenERP_Cloud_Configuration
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
export JENKINS_VCS_PATH=servers/jenkins
export JENKINS_VCS_DIR=${GIT_MANAGED_DIR}/${JENKINS_VCS_PATH}
#
sudo chown -R $ADMIN_USERZ_UID:$ADMIN_USERZ_UID ${ADMIN_USERZ_HOME}
sudo chown -R $JENKINS_USERZ_UID:$JENKINS_USERZ_UID ${JENKINS_VCS_DIR}

#
echo "Script to choose correct Java for SmartGit ..."
echo "sudo update-alternatives --set java /usr/lib/jvm/jdk/jre/bin/java" >> ${ADMIN_USERZ_HOME}/Desktop/FinalTweaks.sh
echo "#" >> ${ADMIN_USERZ_HOME}/Desktop/FinalTweaks.sh


