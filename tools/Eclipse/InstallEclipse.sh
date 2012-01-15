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
# Obtain Eclipse
SRV_ECLIPSE="http://www.eclipse.org/downloads/download.php?file="

#wget -cNb --output-file=dldEclipse.log ${SRV_ECLIPSE}/technology/epp/downloads/release/helios/SR2/eclipse-jee-helios-SR2-linux-gtk.tar.gz
sudo rm -f dldEclipse.log*
echo "Obtaining Helios.."
wget -cNb --output-file=dldEclipse.log ${LOCAL_MIRROR}/eclipse-jee-helios-SR2-linux-gtk.tar.gz
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldEclipse.log -p eclipse-jee-helios
#
sudo mkdir -p ${PRG}/org
cd ${PRG}/org
pwd
echo "Expanding Helios.."
sudo tar zxvf ${INS}/eclipse-jee-helios-SR2-linux-gtk.tar.gz
echo "Symlinking Helios.."
export ECLIPSE_HOME=${PRG}/org/eclipse
sudo chown -R yourself:yourself ${ECLIPSE_HOME}


#

echo "Creating panel button.."
#
cd ${PRG}/installTools
#
wget -cN ${SRV_CONFIG}/tools/InsertInFile.sh
chmod +x ./InsertInFile.sh
#

PANEL_CONFIG=${ADMIN_USERZ_HOME}/.config/lxpanel/LXDE/panels
# TOP_PANEL_CONFIG=${ADMIN_USERZ_HOME}/.config/lxpanel/LXDE/panels/top
cd ${ADMIN_USERZ_WORK_DIR}
#
LAUNCHER=eclipse.desktop
APPLICATIONS=/usr/share/applications
#
wget -cN ${SRV_CONFIG}/tools/Eclipse/$LAUNCHER
sudo chown root:root $LAUNCHER
sudo chmod 644 $LAUNCHER
sudo mv $LAUNCHER $APPLICATIONS
#
cp $PANEL_CONFIG/top .

INSERTION="    Button \{\n            id=$APPLICATIONS/$LAUNCHER\n        }\n    "
EOF_MARKER="\}"
FILE=top
${PRG}/installTools/InsertInFile.sh -i "${INSERTION}" -s "${EOF_MARKER}" -f ${FILE}

rm -f ./top
mv ./top.new $PANEL_CONFIG/top

tail -n 25  $PANEL_CONFIG/top
ls -l
ls -l $APPLICATIONS/ecl*
exit 0;

