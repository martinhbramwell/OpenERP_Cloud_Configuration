export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
export FAILURE_NOTICE="______Looks_like_it_failed______"
			export ADMIN_USERZ_UID=yourself
			export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
			export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
			mkdir -p $ADMIN_USERZ_WORK_DIR
echo "============  Some preparations for later use  ============="
echo "============================================================"
#
# Obtain Download Confirmation script
cd ${PRG}
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
wget ${SRV_CONFIG}/tools/waitForCompleteDownload.sh
chmod +x ./waitForCompleteDownload.sh
#
#
# Initiate downloading the installers we're going to need.
cd ${INS}
# Obtain Java Development Kit 7 
SRV_ORACLE="http://download.oracle.com/otn-pub"
wget -cNb --output-file=dldJdk.log ${SRV_ORACLE}/java/jdk/7u2-b13/jdk-7u2-linux-x64.tar.gz
#
# Obtain Apache Maven 3.0.3
SRV_APACHE="http://mirror.cc.columbia.edu/pub/software/apache"
wget -cNb --output-file=dldMaven.log ${SRV_APACHE}/maven/binaries/apache-maven-3.0.3-bin.tar.gz
#
# Obtain TomCat 7
wget -cNb --output-file=dldTomcat.log ${SRV_APACHE}/tomcat/tomcat-7/v7.0.23/bin/apache-tomcat-7.0.23.tar.gz
#
# Obtain Psi Probe
SRV_PSIPROBE="http://psi-probe.googlecode.com"
wget -cNb --output-file=dldProbe.log ${SRV_PSIPROBE}/files/probe-2.3.0.zip
#
# Obtain Jenkins
SRV_JENKINS="http://mirrors.jenkins-ci.org"
wget -cNb --output-file=dldJenkinsWar.log ${SRV_JENKINS}/war/latest/jenkins.war
#
#
# Obtain and install 
# - curl
# - unzip
# - gcc
# - autoconf
# - make
# - git-core
# 
sudo apt-get -y install curl unzip gcc autoconf make git-core
#
echo "Install Oracle's Java JDK 7"
# Use JDK 7 obtained earlier 
# wget -cNb --output-file=dldJdk.log http://download.oracle.com/otn-pub/java/jdk/7u2-b13/jdk-7u2-linux-x64.tar.gz
cd ${INS}
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldJdk.log -p jdk-7u2
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
sudo tar zxvf ${INS}/jdk-7u2-linux-x64.tar.gz
sudo ln -sf jdk1.7.0_02/ jdk
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk/jre/bin/java 1
sudo update-alternatives --config java
cd ~/
#
echo "Expect :"
echo " java version \"1.7.0_02\""
echo "  Java(TM) SE Runtime Environment (build 1.7.0_02-b13)"
echo "  java HotSpot(TM) 64-Bit Server VM (build 22.0-b10, mixed mode)"
echo "Calling java -version..."
java -version

echo " * * * Prepare Maven"
echo "Prepare Maven 3.0.3"

# Use Maven 3.0.3 obtained earlier
# wget -cNb --output-file=dldMaven.log ${SRV_APACHE}/maven/binaries/apache-maven-3.0.3-bin.tar.gz
cd ${INS}
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldMaven.log -p maven-3.0.3
tar -xzvf apache-maven-3.0.3-bin.tar.gz
sudo rm -fr /usr/share/apache-maven-3.0.3
sudo mv apache-maven-3.0.3 /usr/share/
sudo ln -sf /usr/share/apache-maven-3.0.3 /usr/share/maven
#
echo " * * * TomCat * * * "
echo "Obtain and install TomCat"

# Use TomCat 7 obtained earlier
# wget -cNb --output-file=dldTomcat.log ${SRV_APACHE}/tomcat/tomcat-7/v7.0.23/bin/apache-tomcat-7.0.23.tar.gz
cd ${INS}
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldTomcat.log -p tomcat-7.0.23
#
# Decompress it into /usr/share
cd /usr/share/
sudo tar -zxvf ${INS}/apache-tomcat-7.0.23.tar.gz
#
# Make a permanent name for it
sudo ln -s ./apache-tomcat-7.0.23/ tomcat
#
# And a local environment variable
export CATALINA_HOME=/usr/share/tomcat
#
echo "Configure TomCat"
# Operate out of Port 80
cd ~/
sudo cp $CATALINA_HOME/conf/server.xml server.xml.tmp
sudo chown yourself:yourself server.xml.tmp
sed 's|Connector port="8080" |Connector port="80" URIEncoding="UTF-8" |' <server.xml.tmp >server.xml
sudo chown root:root server.xml
sudo cp server.xml $CATALINA_HOME/conf
sudo rm -f server.xml*
#
echo "Restart it."
 # Start it up
 sudo $CATALINA_HOME/bin/startup.sh
 #
echo "Check it's ok."
 #  Check it worked
 cd ${PRG}
 if [ ! -f "waitForTomcat.sh" ]; then wget ${SRV_CONFIG}/tools/waitForTomcat.sh; fi
 chmod a+x waitForTomcat.sh
 ./waitForTomcat.sh
echo "Stop it again."
 # Shut it down.
 sudo $CATALINA_HOME/bin/shutdown.sh
 #

