#!/bin/bash
# Script to create an SSH key pair and provide it to SSH-AGENT.
#
export LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
export JENKINS_USERZ_UID=jenkins
export JENKINS_USERZ_HOME=/home/$JENKINS_USERZ_UID
#
echo "Make a place for the RSA key at $JENKINS_USERZ_HOME/.ssh ..."
#
sudo rm -fr $JENKINS_USERZ_HOME/.ssh/
#
sudo -u $JENKINS_USERZ_UID mkdir -p $JENKINS_USERZ_HOME/.ssh
sudo chmod 770 $JENKINS_USERZ_HOME/.ssh
#
#     echo "Make RSA key.."  ##   Better to get it locally.  See below.
#
#     sudo -u jenkins ssh-keygen -N "okokok" -t rsa -f $JENKINS_USERZ_HOME/.ssh/id_rsa
#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa
#     sudo chmod -R 660 $JENKINS_USERZ_HOME/.ssh/id_rsa.pub
echo "Get RSA key from local file server."
cd $JENKINS_USERZ_HOME/.ssh
sudo -u $JENKINS_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/known_hosts
sudo -u $JENKINS_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/id_rsa
sudo -u $JENKINS_USERZ_UID wget -cN ${LOCAL_MIRROR}/ssh/id_rsa.pub
sudo -u $JENKINS_USERZ_UID chmod 600 id_rsa*
#
echo "Check it works..."
sudo -Hu jenkins ssh -T git@github.com
#
echo "Permit SmartGit access too."
sudo -u $JENKINS_USERZ_UID chmod 660 id_rsa*
ls -la 







