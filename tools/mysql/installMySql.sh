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
sudo bin/mysqld_safe --user=mysql &
#
echo "Start/Stop scripts for MySql ..."
sudo cp support-files/mysql.server /etc/init.d/mysql.server
         #
         #
         #
#
exit;
         #
         #
         #

cd /usr/local/mysql/bin
./mysql -u root -D mysql -ss -n -q <<EOF
#
CREATE DATABASE redorademo;
CREATE USER 'redora'@'openerpdbs.warehouseman.com' IDENTIFIED BY 'password';
GRANT ALL ON redorademo.* TO 'redora'@'openerpdbs.warehouseman.com';
FLUSH PRIVILEGES;
#

EOF
exit


# # Installing MySQL system tables...
# OK
# Filling help tables...
# OK
# 
# To start mysqld at boot time you have to copy
# support-files/mysql.server to the right place for your system
# 
# PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
# To do so, start the server, then issue the following commands:
# 
# ./bin/mysqladmin -u root password 'new-password'
# ./bin/mysqladmin -u root -h OpenERP-DatabaseServer password 'new-password'
# 
# Alternatively you can run:
# ./bin/mysql_secure_installation
# 
# which will also give you the option of removing the test
# databases and anonymous user created by default.  This is
# strongly recommended for production servers.
# 
# See the manual for more instructions.
# 
# You can start the MySQL daemon with:
# cd . ; ./bin/mysqld_safe &
# 
# You can test the MySQL daemon with mysql-test-run.pl
# cd ./mysql-test ; perl mysql-test-run.pl
# 
# Please report any problems with the ./bin/mysqlbug script!

