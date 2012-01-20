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
echo "Get the config file."
cd $JENKINS_USERZ_JOBS_DIR
sudo -u jenkins mkdir -p $FIRST_JOB_DIR
cd $FIRST_JOB_DIR
pwd
echo wget ${SRV_CONFIG}/$JENKINS_DIR/$FIRST_JOB_DIR/$FIRST_JOB_CONFIG
echo "Got the config file."
#

