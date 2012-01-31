#!/bin/bash
# Script to prepare an empty Jenkins server with an empty Fitnesse wiki.
#
export INS="/home/yourself/installers"
export PRG="/home/yourself/programs"
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
export JENKINS_USERZ_SSH_DIR=${JENKINS_USERZ_HOME}/.ssh
	#
export GIT_MANAGED_PROJECT=Cloud-Fitnesse-Tester
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
	#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/${GIT_MANAGED_PROJECT}/master"
#
  echo "Prepare a Git Repo to contain the Jenkins Project : "
#
export GIT_SOURCE=git@github.com:martinhbramwell
export MASTER_PROJECT=${GIT_SOURCE}/${GIT_MANAGED_PROJECT}.git
mkdir -p ${ADMIN_USERZ_DEV_DIR}
cd ${ADMIN_USERZ_DEV_DIR}
rm -fr ${GIT_MANAGED_PROJECT}
mkdir -p ${GIT_MANAGED_PROJECT}
  echo "${JENKINS_USERZ_UID_UC} needs to own the whole hierarchy ..."
sudo chown ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${GIT_MANAGED_PROJECT}
	#
  echo "Clone the whole Cloud-Fitnesse-Tester project into the Git managed directory :"
# The next step requires tight security so use 600
sudo -Hu ${JENKINS_USERZ_UID} chmod 600 ${JENKINS_USERZ_SSH_DIR}/*
sudo -Hu ${JENKINS_USERZ_UID} git clone ${MASTER_PROJECT} ${GIT_MANAGED_PROJECT}
# Undo tight security so Jenkins & SmartGit can share the key
sudo -Hu ${JENKINS_USERZ_UID} chmod 660 ${JENKINS_USERZ_SSH_DIR}/*
#

