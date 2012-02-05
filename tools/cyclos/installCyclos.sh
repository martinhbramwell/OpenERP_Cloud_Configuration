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
#
export MYSQL_HOME=${PRG}/com/${MYSQL_USERZ_UID}
export MYSQL_BIN_DIR=${MYSQL_HOME}/bin
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain Cyclos
SRV_CYCLOS="http:///sourceforge.net/projects/cyclos/files/Cyclos3/3.6"

#wget -cNb --output-file=dldCyclos.log ${SRV_CYCLOS}/cyclos_3.6.zip
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
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} /usr/share/tomcat/*
#
cd ${MYSQL_BIN_DIR}
echo "Define root password ..."
./mysqladmin -u root password 'okok' > /dev/null 2>&1
#
echo "Create Cyclos user and set privileges ..."
./mysql -u root -pokok -D mysql -ss -n -q <<EOF
CREATE DATABASE cyclos3;
CREATE USER 'cyclos'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'cyclos'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER 'cyclos'@'192.168.1.%' IDENTIFIED BY 'password';
CREATE USER 'cyclos'@'192.168.122.%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON cyclos3.* TO 'cyclos'@'localhost' IDENTIFIED BY 'okok';
GRANT ALL PRIVILEGES ON cyclos3.* TO 'cyclos'@'127.0.0.1' IDENTIFIED BY 'okok';
GRANT ALL PRIVILEGES ON cyclos3.* TO 'cyclos'@'192.168.1.%' IDENTIFIED BY 'okok';
GRANT ALL PRIVILEGES ON cyclos3.* TO 'cyclos'@'192.168.122.%' IDENTIFIED BY 'okok';
FLUSH PRIVILEGES;
EOF
#
exit 0;
