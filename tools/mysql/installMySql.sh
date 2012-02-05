#! /bin/bash 
# script to go and get MySql complete packages.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p ${ADMIN_USERZ_WORK_DIR}
#
export INS="${ADMIN_USERZ_HOME}/installers"
export PRG="${ADMIN_USERZ_HOME}/programs"
#
export MYSQL_USERZ_UID=mysql
export MYSQL_USERZ_HOME=/home/${MYSQL_USERZ_UID}
export MYSQL_USERZ_WORK_DIR=/home/${MYSQL_USERZ_UID}/tmp
mkdir -p ${MYSQL_USERZ_WORK_DIR}
#
export MYSQL_HOME=${PRG}/com/${MYSQL_USERZ_UID}
export MYSQL_BIN_DIR=${MYSQL_HOME}/bin
mkdir -p ${MYSQL_BIN_DIR}
#
sudo groupadd ${MYSQL_USERZ_UID}
sudo useradd -r -g ${MYSQL_USERZ_UID} ${MYSQL_USERZ_UID}
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain MySql
MYSQL_PKG="mysql-5.5.20-debian6.0-x86_64.deb "
SRV_MYSQL="http://mysql.mirrors.pair.com/Downloads/MySQL-5.5"
#
#wget -cNb --output-file=dldMySql.log ${SRV_MYSQL}/${MYSQL_PKG}
sudo rm -f dldMySql.log*
echo "Obtaining MySql ..."
wget -cNb --output-file=dldMySql.log ${LOCAL_MIRROR}/${MYSQL_PKG}
#
FAIL_PATTERN="nothing to do|ERROR"
GENERIC_PATTERN=".+saved"
SUCCESS_PATTERN="mysql-5.5.20"$GENERIC_PATTERN
${PRG}/installTools/waitForLogFileEvent.sh -d 360 -l ./dldMySql.log -s ${SUCCESS_PATTERN} -f ${FAIL_PATTERN}
#
#
#
if [  1 == 1  ]; then
echo "Installing MySql ..."
sudo dpkg -i ${INS}/${MYSQL_PKG}
#
fi
echo "Preparing access ..."
#
sudo mkdir -p ${PRG}/com
rm -fr ${MYSQL_HOME}
sudo ln -s /opt/mysql/server-5.5 ${MYSQL_HOME}
cd ${MYSQL_HOME}
#
sudo chown    ${MYSQL_USERZ_UID}:${MYSQL_USERZ_UID} /opt/mysql
sudo chown -R ${MYSQL_USERZ_UID}:${MYSQL_USERZ_UID} /opt/mysql/*
#
# sudo chown -R root .
# sudo chown -R mysql data
#
pwd
echo "Default MySql internals ..."
# Requires libaio1
sudo apt-get install libaio1
sudo scripts/mysql_install_db --user=mysql
#
sudo cp support-files/my-medium.cnf /etc/my.cnf
#
echo "Start/Stop scripts for MySql ..."
sudo cp support-files/mysql.server /etc/init.d/mysql.server
sudo ln -s /etc/init.d/mysql.server /etc/rc1.d/K99mysql
sudo ln -s /etc/init.d/mysql.server /etc/rc2.d/S99mysql
#
sudo /etc/init.d/mysql.server restart
#
#
#
exit 0;

