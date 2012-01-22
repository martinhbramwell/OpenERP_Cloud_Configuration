#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
mkdir -p $ADMIN_USERZ_WORK_DIR
#
# Initiate downloading the installers we're going to need.
cd ${INS}
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
# Obtain NX
SRV_NX="http://64.34.161.181/download/3.5.0/Linux"

#wget -cNb --output-file=dldNXc.log ${SRV_NX}/nxclient_3.5.0-7_amd64.deb
sudo rm -f dldNXc.log*
echo "Obtaining FreeNX client.."
wget -cNb --output-file=dldNXc.log ${LOCAL_MIRROR}/nxclient_3.5.0-7_amd64.deb
#
#wget -cNb --output-file=dldNXn.log ${SRV_NX}/nxnode_3.5.0-7_amd64.deb
sudo rm -f dldNXn.log*
echo "Obtaining FreeNX node.."
wget -cNb --output-file=dldNXn.log ${LOCAL_MIRROR}/nxnode_3.5.0-7_amd64.deb
#
#wget -cNb --output-file=dldNXs.log ${SRV_NX}/nxserver_3.5.0-9_amd64.deb
sudo rm -f dldNXs.log*
echo "Obtaining FreeNX server.."
wget -cNb --output-file=dldNXs.log ${LOCAL_MIRROR}/nxserver_3.5.0-9_amd64.deb
#
export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
wget ${SRV_CONFIG}/tools/waitForLogFileEvent.sh
chmod +x ./waitForLogFileEvent.sh
#
FAIL_PATTERN="nothing to do|ERROR"

${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldNXc.log -s nxclient_3.5 -f ${FAIL_PATTERN}
sudo dpkg -i nxclient_3.5.0-7_amd64.deb
#
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldNXn.log -s nxnode_3.5 -f ${FAIL_PATTERN}
sudo dpkg -i nxnode_3.5.0-7_amd64.deb
#
${PRG}/installTools/waitForLogFileEvent.sh -d 3600 -l ./dldNXs.log -s nxserver_3.5 -f ${FAIL_PATTERN} 
sudo dpkg -i nxserver_3.5.0-9_amd64.deb
#
exit 0;

