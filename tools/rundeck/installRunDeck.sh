#! /bin/bash 
# script to go and get RunDeck complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain RunDeck
SRV_CYCLOS="https://github.com/downloads/dtolabs/rundeck"

#wget -cNb --output-file=dldRunDeck.log ${SRV_CYCLOS}/rundeck-1.4.1-1.deb
sudo rm -f dldRunDeck.log*
echo "Obtaining RunDeck ..."
wget -cNb --output-file=dldRunDeck.log ${LOCAL_MIRROR}/rundeck-1.4.1-1.deb
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldRunDeck.log -p rundeck
#
#
# 
cd ${PRG}/org
pwd
echo "Expanding RunDeck ..."
sudo unzip -f ${INS}/rundeck-1.4.1-1.deb
echo "Preparing RunDeck ..."
sudo ln -s cyclos_3.6 cyclos
#
export CYCLOS_HOME=${PRG}/org/cyclos
sudo chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${ADMIN_USERZ_HOME}
#
echo "Fiddling TomCat for RunDeck ..."
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
echo "Create RunDeck user and set privileges ..."
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
