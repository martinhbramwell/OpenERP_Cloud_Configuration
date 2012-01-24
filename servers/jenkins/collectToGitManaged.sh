#!/bin/bash
# Script to collect Jenkins server artifacts for version control
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
export JENKINS_USERZ_DATA_DIR=$JENKINS_USERZ_HOME/.$JENKINS_USERZ_UID
export JENKINS_USERZ_JOBS_DIR=$JENKINS_USERZ_DATA_DIR/jobs
#
cp /home/jenkins/.jenkins/config.xml .

