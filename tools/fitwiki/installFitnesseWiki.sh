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
export GIT_MANAGED_PROJECT=OpenERP_Cloud_Configuration
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
	#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/${GIT_MANAGED_PROJECT}/master"
#
export GIT_SOURCE=git@github.com:martinhbramwell
export MASTER_PROJECT=${GIT_SOURCE}/${GIT_MANAGED_PROJECT}.git
#
export FITNESSE_VCS_PATH=servers/fitnesse
export FITNESSE_VCS_DIR=${GIT_MANAGED_DIR}/${FITNESSE_VCS_PATH}
#
export JENKINS_VCS_PATH=servers/jenkins
export JENKINS_VCS_DIR=${GIT_MANAGED_DIR}/${JENKINS_VCS_PATH}
#
export LOCAL_FITNESSE_WIKI_NAME=FlyByNightCloud
export FITNESSE_ROOT=FitNesseRoot
export LOCAL_FITNESSE_ROOT_DIR=${FITNESSE_VCS_DIR}/${LOCAL_FITNESSE_WIKI_NAME}/${FITNESSE_ROOT}
export LOCAL_FITNESSE_WIKI=${LOCAL_FITNESSE_ROOT}/${LOCAL_FITNESSE_WIKI_NAME}
export LOCAL_FITNESSE_WIKI_FRONT_PAGE_DIR=${LOCAL_FITNESSE_ROOT_DIR}/FrontPage
export LOCAL_FITNESSE_WIKI_FRONT_PAGE=${LOCAL_FITNESSE_WIKI_FRONT_PAGE_DIR}/content.txt
export FITNESSE_JENKINS_WORKSPACE=workspace/StartFitnesse
export FITNESSE_JENKINS_WORKSPACE_DIR=${JENKINS_VCS_DIR}/${FITNESSE_JENKINS_WORKSPACE}
#
pwd
#
  echo "Prepare a home for the local Fitnesse root and make the Jenkins group the owners : "
sudo mkdir -p ${LOCAL_FITNESSE_WIKI_FRONT_PAGE_DIR}
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${FITNESSE_VCS_DIR}
sudo chmod -R g+rw ${FITNESSE_VCS_DIR}
#
#
  echo "Prepare a link from the Fitnesse workspace in Jenkins to the above wiki root and make Jenkins and its group the owners : "
sudo mkdir -p ${FITNESSE_JENKINS_WORKSPACE_DIR}
sudo rm -fr ${FITNESSE_JENKINS_WORKSPACE_DIR}/${FITNESSE_ROOT}
sudo ln -s ${LOCAL_FITNESSE_ROOT_DIR} ${FITNESSE_JENKINS_WORKSPACE_DIR}/${FITNESSE_ROOT}
sudo chown -R ${JENKINS_USERZ_UID}:${JENKINS_USERZ_UID} ${JENKINS_VCS_DIR}
sudo chmod -R g+rw ${JENKINS_VCS_DIR}

