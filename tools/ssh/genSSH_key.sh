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
rm -fr ${SSH_DIR}/
#
mkdir -p ${SSH_DIR}
chmod 770 ${SSH_DIR}
#
echo "Make RSA key.."  ##   It'd be better to get it locally.  See below.
#
ssh-keygen -N "aPassword" -t rsa -f ${SSH_DIR}/id_rsa
chmod -R 660 ${SSH_DIR}/id_rsa
chmod -R 660 ${SSH_DIR}/id_rsa.pub

ls -l ${SSH_DIR}
echo "= = = Done = = = "

