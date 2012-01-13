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
${PRG}/waitForCompleteDownload.sh -d 3600 -l ./dldEclipse.log -p eclipse-jee-helios
#
export ECLIPSE_HOME=${PRG}/org/eclipse
sudo mkdir -p ${ECLIPSE_HOME}
cd ${ECLIPSE_HOME}
echo "Expanding Helios.."
sudo tar zxvf ${INS}/eclipse-jee-helios-SR2-linux-gtk.tar.gz
echo "Symlinking Helios.."
sudo ln -s eclipse-jee-helios-SR2-linux-gtk.tar.gz eclipse
export HELIOS_HOME=${ECLIPSE_HOME}/eclipse
echo "Creatng panel button.."

exit 1;
TOP_PANEL_CONFIG=${ADMIN_USERZ_HOME}/.config/lxpanel/LXDE/panels/top
# EOF_MARKER="        }\n    }\n}"
EOF_MARKER="Button {"
# NEW_BUTTON_TO_ADD="        }\n        Button {\n            id=/usr/share/applications/lxterminal.desktop\n        }\n    }\n}\n"
NEW_BUTTON_TO_ADD="Button   {"

cat ${TOP_PANEL_CONFIG} \
  | sed -e "s|${EOF_MARKER}|${NEW_BUTTON_TO_ADD}|g" \
   > ${TOP_PANEL_CONFIG}.new
#
cat ${TOP_PANEL_CONFIG}.new

    
