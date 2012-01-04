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
echo " "
echo -n "Connect terminal to :: " &&  ip addr show eth0 | grep "inet "
echo " "
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
cd $ADMIN_USERZ_HOME
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
cd $ADMIN_USERZ_HOME
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
echo "Configure TomCat"
# Operate out of Port 80
cd $ADMIN_USERZ_WORK_DIR
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
#
echo " * * * Psi Probe * * * "
echo "Get Psi Probe"
#
# Use Psi Probe obtained earlier
# wget -cNb --output-file=dldProbe.log http://psi-probe.googlecode.com/files/probe-2.3.0.zip
cd ${INS}
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldProbe.log -p probe-2.3.0
#
mkdir -p $ADMIN_USERZ_WORK_DIR
cd $ADMIN_USERZ_WORK_DIR
rm -f probe.war
rm -f Changelog.txt
unzip ${INS}/probe-2.3.0.zip 
sudo mv probe.war $CATALINA_HOME/webapps/
#
echo " * * * Psi Probe is way better than TomCat's 'Manager'"
echo "Configure Psi Probe"
#
# Add the access role
sudo cp $CATALINA_HOME/conf/tomcat-users.xml tu.x
sudo chown yourself:yourself tu.x
#
MARK="<\/tomcat-users>"
ROLE="<role rolename=\"manager\"\/>"
USER="<user username=\"yourself\" password=\"okok\" roles=\"manager\"\/>"
SUBS="  $ROLE\\n  $USER\\n$MARK"   ##  "
#
sed "s|$MARK|$SUBS|"  <tu.x >tomcat-users.xml
#
sudo chown root:root tomcat-users.xml
sudo mv tomcat-users.xml $CATALINA_HOME/conf/
cd $ADMIN_USERZ_HOME/
rm -fr $ADMIN_USERZ_WORK_DIR
#
# Restart Tomcat
sudo /etc/rc2.d/S99tomcat stop
sudo /etc/rc2.d/S99tomcat start
#
# Checked it worked
cd ${PRG}
if [ ! -f "waitForPsiProbe.sh" ]; then wget ${SRV_CONFIG}/tools/waitForPsiProbe.sh; fi
chmod a+x waitForPsiProbe.sh
./waitForPsiProbe.sh
cd $ADMIN_USERZ_WORK_DIR
#
echo "Jenkins will need to know where Git resides. Apt puts it at : '/usr/bin/git'"
echo "It will also expect Git to have been configured. Jenkins requires this to be done AS the jenkins user, so do the following ..."
echo "Configure Git so Jenkins can use it :"
#
sudo -sHu jenkins
cd /home/jenkins
git config --global user.name "yourself"
git config --global user.email "yourself@warehouseman.com"
git config --global push.default "matching"
exit

echo "Jenkins Continuous Integration"
echo "Obtain Jenkins"
#
# Use Jenkins Web Archive file obtained earlier
# wget -cNb --output-file=dldJenkinsWar.log http://mirrors.jenkins-ci.org/war/latest/jenkins.war
cd ${INS}
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldJenkinsWar.log -p jenkins.war
#
echo "Move the war into TomCat's webapps directory ..."
#
# Move war to TomCat
sudo mv jenkins.war $CATALINA_HOME/webapps/
#
echo "... and confirm that it's working :"
#
# Checked it worked
cd $ADMIN_USERZ_WORK_DIR
if [ ! -f "waitForJenkins.sh" ]; then wget ${SRV_CONFIG}/tools/waitForJenkins.sh; fi
chmod a+x waitForJenkins.sh
./waitForJenkins.sh
#
echo " * * * Prepare Jenkins * * * "
echo "Install plugins"
echo " "
echo "For automated install of plugins, the download site for the plugins is here : http://updates.jenkins-ci.org/download/plugins/"
echo " "
echo "Here is the script for automating that :"
echo " "
# Extract the Jenkins Command Line Interface
cd ${PRG}
wget $JENKINS_URL/jnlpJars/jenkins-cli.jar
#
# Health check
JNKNSVRSN=$(java -jar jenkins-cli.jar version)
RSLT=$(echo "$JNKNSVRSN" | grep -c "$JENKINS_VERSION")
test $RSLT -gt 0 && echo "Jenkins command line interface responds," || echo $FAILURE_NOTICE
#
# Restart Tomcat
sudo /etc/rc2.d/S99tomcat stop
sudo /etc/rc2.d/S99tomcat start
#
# Install our various needed plugins
java -jar jenkins-cli.jar -s $JENKINS_URL install-plugin github
java -jar jenkins-cli.jar -s $JENKINS_URL install-plugin saferestart
#
# Restart Jenkins
java -jar jenkins-cli.jar -s $JENKINS_URL safe-restart

echo "Restart as described above and turn to the Manage Jenkins >> Configure System page."


