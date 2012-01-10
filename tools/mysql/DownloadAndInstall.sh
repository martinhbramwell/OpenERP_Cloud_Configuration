#
#
sudo mkdir -p /tmp/dld
cd /tmp/dld
wget http://mysql.mirrors.pair.com/Downloads/MySQL-5.5/mysql-5.5.19-linux2.6-i686.tar.gz
#
sudo apt-get install libaio1
#
sudo groupadd mysql
sudo useradd -r -g mysql mysql
cd /usr/local
sudo tar zxvf /tmp/dld/mysql-5.5.19-linux2.6-i686.tar.gz
sudo ln -s mysql-5.5.19-linux2.6-i686 mysql
cd mysql
sudo chown -R mysql .
sudo chgrp -R mysql .
sudo apt-get install libaio
#
# Requires libaio1
sudo scripts/mysql_install_db --user=mysql
#
sudo chown -R root .
sudo chown -R mysql data
# Next command is optional
sudo cp support-files/my-medium.cnf /etc/my.cnf
sudo bin/mysqld_safe --user=mysql &
# Next command is optional
sudo cp support-files/mysql.server /etc/init.d/mysql.server

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

