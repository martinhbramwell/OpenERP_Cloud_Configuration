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
echo "Pull in all remote changes to Git-managed repo  ............"
git pull
#
echo "Extract RunDeck jobs to Git-managed repo  .................."
rd-jobs list -f ./projects/PrepareGenericVPS/jobs.yaml -F yaml -p PrepareGenericVPS
#
echo "Add new files if any  ......................................"
git add --all -- *.yaml
#
echo "Commit the changed files  .................................."
git commit --allow-empty -a -m "New/changed for PrepareGenericVPS"
#
echo "Syncchronize with master repository  ......................."
git push
#
echo "Done  ......................................................"
#
popd
#

