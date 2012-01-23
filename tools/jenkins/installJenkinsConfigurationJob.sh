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
mkdir -p ${PRG}/installTools
cd ${PRG}/programs/installTools/
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


