#! /bin/bash 
# script to create SSH key for RunDeck complete packages.
#
CURRENT_UID=$( whoami )
#
cd ~
CURRENT_DIR=$( pwd )
SSH_DIR=${CURRENT_DIR}/.ssh
#
#		
echo "Make a place for the RSA key at ${SSH_DIR} on behalf of user ${CURRENT_UID}..."
#
sudo rm -fr ${SSH_DIR}/
#
sudo -u ${CURRENT_UID} mkdir -p ${SSH_DIR}
sudo chmod 770 ${SSH_DIR}
sudo chown -R ${CURRENT_UID}:${CURRENT_UID} ${CURRENT_DIR}
#
echo "Make RSA key.."  ##   It'd be better to get it locally.  See below.
#
sudo -u ${CURRENT_UID} ssh-keygen -N "aPassword" -t rsa -f ${SSH_DIR}/id_rsa
sudo chmod -R 660 ${SSH_DIR}/id_rsa
sudo chmod -R 660 ${SSH_DIR}/id_rsa.pub

ls -l ${SSH_DIR}
echo "= = = Done = = = "

