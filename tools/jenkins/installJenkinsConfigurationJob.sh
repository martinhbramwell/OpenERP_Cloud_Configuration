#!/bin/bash
# Script to prepare an empty Jenkins server with an empty Fitnesse wiki.
#
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
export FAILURE_NOTICE="______Looks_like_it_failed______"
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_DEV_DIR=/home/${ADMIN_USERZ_UID}/dev
export ADMIN_USERZ_WORK_DIR=/home/${ADMIN_USERZ_UID}/tmp
mkdir -p ${ADMIN_USERZ_WORK_DIR}
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_UID_UC=Jenkins
export JENKINS_USERZ_HOME=/home/${JENKINS_USERZ_UID}
export JENKINS_USERZ_DATA_DIR=${JENKINS_USERZ_HOME}/.${JENKINS_USERZ_UID}
export JENKINS_USERZ_JOBS_DIR=${JENKINS_USERZ_DATA_DIR}/jobs
export JENKINS_USERZ_SSH_DIR=${JENKINS_USERZ_HOME}/.ssh
export JENKINS_COMMAND_DIR=${PRG}/org/${JENKINS_USERZ_UID}
#
export GIT_MANAGED_PROJECT=OpenERP_Cloud_Configuration
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
export JENKINS_VCS_PATH=servers/jenkins
export JENKINS_VCS_DIR=${GIT_MANAGED_DIR}/${JENKINS_VCS_PATH}
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
export LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
export CATALINA_HOME=/usr/share/tomcat
#
export   JENKINS_URL=http://localhost/jenkins
# export JENKINS_URL=http://test.warehouseman.com/jenkins/
#
export FIRST_JOB_DIR=ConfigFilesSCM
##
sudo rm -fr ${ADMIN_USERZ_DEV_DIR}
mkdir ${ADMIN_USERZ_DEV_DIR}
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${ADMIN_USERZ_DEV_DIR}
#
echo "Jenkins Continuous Integration"
echo "Obtain Jenkins"
cd ${INS}
rm -f ./dldJenkinsWar.log*
rm -f ./jenkins.war
wget -cNb --output-file=dldJenkinsWar.log ${LOCAL_MIRROR}/jenkins.war
# export SRV_JENKINS="http://mirrors.jenkins-ci.org"
# wget -cNb --output-file=dldJenkinsWar.log ${SRV_JENKINS}/war/latest/jenkins.war
#
# Prerequisite : waitForLogFileEvent.sh
#
mkdir -p ${PRG}/installTools
cd ${PRG}/installTools/
rm -f ./waitForLogFileEvent.sh
wget ${SRV_CONFIG}/tools/waitForLogFileEvent.sh
chmod +x ./waitForLogFileEvent.sh
#
#
echo "Jenkins will need to know where Git resides. Apt puts it at : '/usr/bin/git'"
echo "It will also expect Git to have been configured. Jenkins requires this to be done AS the jenkins user, so do the following ..."
#
echo "Configure Git so Jenkins can use it :"
echo "--- name"
sudo -Hu $JENKINS_USERZ_UID git config --global user.name "$JENKINS_USERZ_UID"
echo "--- mail"
sudo -Hu $JENKINS_USERZ_UID git config --global user.email "$JENKINS_USERZ_UID@warehouseman.com"
echo "--- push default"
sudo -Hu $JENKINS_USERZ_UID git config --global push.default "matching"
#
#
echo "Prepare a Git Repo to contain the Jenkins Project : "
#
export GIT_SOURCE=git@github.com:martinhbramwell
export MASTER_PROJECT=${GIT_SOURCE}/${GIT_MANAGED_PROJECT}.git
mkdir -p ${ADMIN_USERZ_DEV_DIR}
echo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${ADMIN_USERZ_DEV_DIR}
cd ${ADMIN_USERZ_DEV_DIR}
rm -fr ${GIT_MANAGED_PROJECT} 
#
echo "Clone the Jenkins Project into the Git Repo :"
# The next step requires tight security so use 600
sudo -Hu ${JENKINS_USERZ_UID} chmod 600 ${JENKINS_USERZ_SSH_DIR}/*
echo sudo -Hu ${JENKINS_USERZ_UID} git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
sudo -Hu $JENKINS_USERZ_UID git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
# Undo tight security so Jenkins & SmartGit can share the key
sudo -Hu ${JENKINS_USERZ_UID} chmod 660 ${JENKINS_USERZ_SSH_DIR}/*
# SmartGit needs to own it all ...
sudo chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${GIT_MANAGED_PROJECT}
#  ... Jenkins needs to own the subdirectory it uses.
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${JENKINS_VCS_DIR}
#
#
echo "Wait for jenkins.war to arrive ..."
SEARCH_PATTERN="jenkins.war' saved"
FAILURE_PATTERN="nothing to do|ERROR"
cd ${INS}
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldJenkinsWar.log -s "${SEARCH_PATTERN}" -f "${FAILURE_PATTERN}"
#
echo "Remove residue of prior installations ..."
sudo rm -fr /home/jenkins/.jenkins
sudo rm -fr $CATALINA_HOME/webapps/jenkins.war
sudo rm -fr $CATALINA_HOME/webapps/jenkins
#
#
# Move war to TomCat
#
echo "Move the war into TomCat's webapps directory ..."
sudo chown $JENKINS_USERZ_UID:$JENKINS_USERZ_UID jenkins.war
sudo mv jenkins.war $CATALINA_HOME/webapps/
#
echo "... and confirm that it's working :"
#
# Checked it worked
#
echo "Halt TomCat"
sudo /etc/rc2.d/S99tomcat stop
#
mkdir -p ${JENKINS_COMMAND_DIR}
chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${JENKINS_COMMAND_DIR}
cd ${JENKINS_COMMAND_DIR}
if [ ! -f "waitForJenkins.sh" ]; then wget ${SRV_CONFIG}/tools/waitForJenkins.sh; fi
chmod a+x waitForJenkins.sh
#
#
echo "Define a symbolic link from the Jenkins Home directory to the Git Managed Jenkins VCS directory"
cd $JENKINS_USERZ_HOME
sudo -u $JENKINS_USERZ_UID mkdir -p $JENKINS_USERZ_DATA_DIR
sudo -u $JENKINS_USERZ_UID mv $JENKINS_USERZ_DATA_DIR $JENKINS_USERZ_DATA_DIR.bk
sudo -u $JENKINS_USERZ_UID ln -s $JENKINS_VCS_DIR $JENKINS_USERZ_DATA_DIR
#
echo "Jenkins will really go to $JENKINS_VCS_DIR when expecting to go to $JENKINS_USERZ_DATA_DIR."
#
echo "Start TomCat again"
sudo /etc/rc2.d/S99tomcat start
#
echo " * * * Prepare Jenkins * * * "
#
sudo wget $JENKINS_URL/reload
echo "Wait for Jenkins to finish restarting"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#
#
# Extract the Jenkins Command Line Interface
#
mkdir -p $ADMIN_USERZ_WORK_DIR
cd $ADMIN_USERZ_WORK_DIR
sudo rm -f jenki*
sudo wget $JENKINS_URL/jnlpJars/jenkins-cli.jar
sudo wget $JENKINS_URL/updateCenter/?auto_refresh=true
sudo wget $JENKINS_URL/pluginManager/checkUpdates#
sudo wget $JENKINS_URL/reload
#
sudo mv jenkins-cli.jar ${JENKINS_COMMAND_DIR}
sudo chown ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${JENKINS_COMMAND_DIR}/jenkins-cli.jar
#
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#
#
# Health check
JNKNSVRSN=$(java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar version)
RSLT=$(echo "$JNKNSVRSN" | grep -c "$JENKINS_VERSION")
test $RSLT -gt 0 && echo "Jenkins command line interface responds," || echo $FAILURE_NOTICE
#
#
#
echo "Stop TomCat"
sudo /etc/rc2.d/S99tomcat stop
#
echo "Install plugins"
echo " "
echo "For automated install of plugins, the download site for the plugins is here : http://updates.jenkins-ci.org/download/plugins/"
echo " "
sudo rm -f *.hpi
sudo rm -fr /home/jenkins/.jenkins/plugins/git*
#
echo "Obtain Git plugin..."
sudo wget -cN ${LOCAL_MIRROR}/git.hpi
#
echo "Obtain GitHub plugin..."
sudo wget -cN ${LOCAL_MIRROR}/github.hpi
#
echo "Obtain GitHub Api plugin..."
sudo wget -cN ${LOCAL_MIRROR}/github-api.hpi
#
#
echo "Obtain Subversion plugin..."
sudo rm -fr /home/jenkins/.jenkins/plugins/subversion*
sudo wget -cN ${LOCAL_MIRROR}/subversion.hpi
#
#
echo "Obtain PostBuild plugin..."
sudo rm -fr /home/jenkins/.jenkins/plugins/postbuild-task*
sudo wget -cN ${LOCAL_MIRROR}/postbuild-task.hpi
# 
# echo "Obtain SafeRestart plugin..."
# sudo rm -fr /home/jenkins/.jenkins/plugins/saferestart*
# sudo wget -cN ${LOCAL_MIRROR}/saferestart.hpi
#
echo "Obtain Fitnesse plugin..."
sudo rm -fr /home/jenkins/.jenkins/plugins/fitnesse*
sudo wget -cN ${LOCAL_MIRROR}/fitnesse.hpi
#
echo "Pass new plugins to Jenkins."
sudo chown $JENKINS_USERZ_UID:$JENKINS_USERZ_UID *.hpi
sudo chmod 644 *.hpi
sudo mv *.hpi /home/jenkins/.jenkins/plugins
#
echo "Start TomCat"
sudo /etc/rc2.d/S99tomcat start
#
cd ${PRG}
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
##
if [ 0 == 1 ]; then
	echo "Scare updateCenter into behaving properly..."
	cd ${ADMIN_USERZ_WORK_DIR}
	sudo curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | sudo curl -X POST -H 'Accept: application/json' -d @- $JENKINS_URL/updateCenter/byId/default/postBack#
	# Install our various needed plugins
	##
	echo "Install GitHub plugin..."
	java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL install-plugin github
	#
	# echo "Install SafeRestart plugin..."
	# java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL install-plugin saferestart
	#
	echo "Install Postbuild plugin..."
	java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL install-plugin postbuild-task
	#
	echo "Install Fitnesse plugin..."
	java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL install-plugin fitnesse
	#
	echo "Install Subversion plugin..."
	java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL install-plugin subversion
	#
	# Restart Jenkins
	echo "Restart Jenkins using SafeRestart plugin..."
	java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s $JENKINS_URL safe-restart
fi
echo "Clear any problem packages"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -f install
#
echo "Make sure default user owns the installation phase tools"
cd ${PRG}
sudo chown -R $ADMIN_USERZ_UID:$ADMIN_USERZ_UID  $ADMIN_USERZ_HOME
#
#
##
if [ 0 == 1 ]; then
	#
	export JENKINS_DIR=tools/jenkins
	#
	export FIRST_JOB_CONFIG=config.xml
	#
	echo "Get the config file."
	cd $JENKINS_USERZ_JOBS_DIR
	sudo -u jenkins mkdir -p $FIRST_JOB_DIR
	cd $FIRST_JOB_DIR
	pwd
	sudo -u jenkins rm -f $FIRST_JOB_CONFIG*
	sudo -u jenkins wget ${SRV_CONFIG}/$JENKINS_DIR/$FIRST_JOB_DIR/$FIRST_JOB_CONFIG
	echo "Got the config file."
	cd $JENKINS_USERZ_HOME
	ls -l $JENKINS_USERZ_JOBS_DIR/$FIRST_JOB_DIR
	#
fi
#
#
echo "Trying to reload."
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} reload-configuration
# sudo wget $JENKINS_URL/reload
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#
#
#
exit
#
#
#
JOB_DIR=${JENKINS_USERZ_JOBS_DIR}/${FIRST_JOB_DIR}
BUILD_NUMBER=$( cat ${JOB_DIR}/nextBuildNumber )
NEXT_BUILD_NUMBER=$(( BUILD_NUMBER + 1 ))
#
echo "Build first job... ${BUILD_NUMBER}"
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} build ${FIRST_JOB_DIR}
#
echo "Wait for first job to start ..."
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ${JOB_DIR}/nextBuildNumber -s ${NEXT_BUILD_NUMBER} -f "0"
BUILD_LOG=${JENKINS_USERZ_JOBS_DIR}/${FIRST_JOB_DIR}/builds/${BUILD_NUMBER}/log
#
DELAY=12
while [ ! -f ${BUILD_LOG} ] && [  ${DELAY} -gt 0 ]
do
    sleep 15
    DELAY=$(( DELAY - 1 ))
    echo "${DELAY} FOR ${BUILD_LOG}"
done
#
echo "Wait for first job to complete ..."
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ${BUILD_LOG} -s "Finished: SUCCESS" -f "FAILED"
#
echo "Pass new jobs to their new homes ..."
#
JOB_RESOURCES=workspace/src/main/resources/jenkins
cd $JENKINS_USERZ_DATA_DIR
cp -fr $JENKINS_USERZ_JOBS_DIR/$FIRST_JOB_DIR/$JOB_RESOURCES/*.xml .
cp -fr $JENKINS_USERZ_JOBS_DIR/$FIRST_JOB_DIR/$JOB_RESOURCES/jobs/* ./jobs
sudo chown -R $JENKINS_USERZ_UID:$JENKINS_USERZ_UID .
#
echo "Trying to reload."
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} reload-configuration
# sudo wget $JENKINS_URL/reload
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#


