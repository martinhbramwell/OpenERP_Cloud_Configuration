#! /bin/bash
# Script to collect prepare an empty Jenkins server with an empty Fitnesse wiki.
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
export JENKINS_USERZ_DATA_DIR=$JENKINS_USERZ_HOME/.$JENKINS_USERZ_UID
export JENKINS_USERZ_JOBS_DIR=$JENKINS_USERZ_DATA_DIR/jobs
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
export JENKINS_DIR=tools/jenkins
export FIRST_JOB_DIR=ConfigFilesSCM
export FIRST_JOB_CONFIG=config.xml
#
export JENKINS_COMMAND_DIR=${PRG}/org/jenkins
#
export JENKINS_URL=http://localhost/jenkins/
# export JENKINS_URL=http://test.warehouseman.com/jenkins/
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
#
sudo wget $JENKINS_URL/reload
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} build ${FIRST_JOB_DIR}
#

