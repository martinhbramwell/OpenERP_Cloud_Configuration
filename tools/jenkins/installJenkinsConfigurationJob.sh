#!/bin/bash
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
export JENKINS_URL=http://localhost/jenkins
# export JENKINS_URL=http://test.warehouseman.com/jenkins/
cd ${PRG}/tools
wget ${SRV_CONFIG}/tools/waitForLogFileEvent.sh
chmod +x ./waitForLogFileEvent.sh
#
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
echo "Trying to reload."
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} reload-configuration
# sudo wget $JENKINS_URL/reload
echo "Wait for Jenkins"
${JENKINS_COMMAND_DIR}/waitForJenkins.sh
#
echo "Build first job..."
java -jar ${JENKINS_COMMAND_DIR}/jenkins-cli.jar -s ${JENKINS_URL} build ${FIRST_JOB_DIR}
#
LATEST_BUILD_NUMBER=$(( $( cat ${JENKINS_USERZ_JOBS_DIR}/${FIRST_JOB_DIR}/nextBuildNumber ) -1 ))
BUILD_LOG=${JENKINS_USERZ_JOBS_DIR}/${FIRST_JOB_DIR}/builds/${LATEST_BUILD_NUMBER}/log
#
echo "Wait for first job to complete ..."
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ${BUILD_LOG} -s "Finished: SUCCESS" -f "FAILED"
#
JOB_RESOURCES=workspace/src/main/resources/jenkins
cd $JENKINS_USERZ_DATA_DIR
cp -fr $JENKINS_USERZ_JOBS_DIR/$FIRST_JOB_DIR/$JOB_RESOURCES/*.xml .
cp -fr $JENKINS_USERZ_JOBS_DIR/$FIRST_JOB_DIR/$JOB_RESOURCES/jobs/* ./jobs


