#!/bin/bash
# This script pulls the latest artifacts from Git and loads them into a running instance of JobDeck
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/${ADMIN_USERZ_UID}
export ADMIN_USERZ_DEV_DIR=/home/${ADMIN_USERZ_UID}/dev
#
export GIT_MANAGED_PROJECT=RunDeckToolSet
export GIT_MANAGED_DIR=${ADMIN_USERZ_DEV_DIR}/${GIT_MANAGED_PROJECT}
#
pushd ${GIT_MANAGED_DIR}
#
echo "Pull the latest version from GitHub ........................"
git pull
#
echo "Restore them into RunDeck .................................."
rd-jobs load -f ./projects/PrepareGenericVPS/jobs.xml
#
echo "Done  ......................................................"
#
popd
#

