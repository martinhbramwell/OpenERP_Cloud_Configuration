#!/bin/bash
# Script to create an SSH key pair and provide it to SSH-AGENT.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_SSH_DIR=${ADMIN_USERZ_HOME}/.ssh
#
export LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_UID_UC=Jenkins
export JENKINS_USERZ_HOME=/home/${JENKINS_USERZ_UID}
#
echo ""
echo ""
echo "We expect a user named ${JENKINS_USERZ_UID_UC}, so create it now....."
echo ""
# Create user jenkins
# (notice : no sudoer capability)
sudo useradd -Um -p "saEV5F6cIIjT2" -c "\"$JENKINS_USERZ_UID_UC\"" "${JENKINS_USERZ_UID}" # saEV5F6cIIjT2 --> password okok

echo "Make a place for the RSA key at $JENKINS_USERZ_HOME/.ssh ..."
#
sudo rm -fr $JENKINS_USERZ_HOME/.ssh/
#
sudo -u ${JENKINS_USERZ_UID} mkdir -p $JENKINS_USERZ_HOME/.ssh
sudo chmod 770 $JENKINS_USERZ_HOME/.ssh
#
#     echo "Make RSA key.."  ##   Better to get it locally.  See below.
#
#     sudo -u jenkins ssh-keygen -N "aPassword" -t rsa -f $JENKINS_USERZ_HOME/.ssh/id_rsa
#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa
#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa.pub
echo "Get RSA key from local file server...................."
cd $JENKINS_USERZ_HOME/.ssh
sudo -u ${JENKINS_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${JENKINS_USERZ_UID}/known_hosts
sudo -u ${JENKINS_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${JENKINS_USERZ_UID}/id_rsa
sudo -u ${JENKINS_USERZ_UID} wget -cN ${LOCAL_MIRROR}/ssh/${JENKINS_USERZ_UID}/id_rsa.pub
sudo -u ${JENKINS_USERZ_UID} chmod 600 id_rsa*
#
echo "Check it works ......................................"
sudo -Hu jenkins ssh -T git@github.com
#
echo "Set privileges ......................................"
sudo -u ${JENKINS_USERZ_UID} chmod 665 id_rsa.pub
ls -la 
#
echo "The admin user needs a copy too ....................."
sudo cp * ${ADMIN_USERZ_SSH_DIR}
sudo chown -R ${ADMIN_USERZ_UID}:${ADMIN_USERZ_UID} ${ADMIN_USERZ_SSH_DIR}
#

