#! /bin/bash 
# script to go and get Cyclos complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_UID_UC=Jenkins
export JENKINS_USERZ_HOME=/home/${JENKINS_USERZ_UID}
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain Cyclos
SRV_ECLIPSE="http:///sourceforge.net/projects/cyclos/files/Cyclos3/3.6"

#wget -cNb --output-file=dldCyclos.log ${SRV_ECLIPSE}/cyclos_3.6.zip
sudo rm -f dldCyclos.log*
echo "Obtaining Cyclos ..."
wget -cNb --output-file=dldCyclos.log ${LOCAL_MIRROR}/cyclos_3.6.zip
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldCyclos.log -p cyclos
#
#
# 
cd ${PRG}/org
pwd
echo "Expanding Cyclos ..."
sudo unzip ${INS}/cyclos_3.6.zip
echo "Preparing Cyclos ..."
sudo ln -s cyclos_3.6 cyclos
#
export CYCLOS_HOME=${PRG}/org/cyclos
sudo chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${ADMIN_USERZ_HOME}
#
echo "Fiddling TomCat for Cyclos ..."
sudo mkdir -p /usr/share/tomcat/logs
cd /usr/share/tomcat
sudo ln -s logs log
#
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} /usr/share/tomcat
#
#
exit 0;
