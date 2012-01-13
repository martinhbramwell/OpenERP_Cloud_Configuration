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
# Obtain Syntevo SmartGit
SRV_SYNTEVO="http://www.syntevo.com"
#wget -cNb --output-file=dldJdk.log ${SRV_SYNTEVO}/download/smartgit/smartgit-generic-2_1_6.tar.gz
sudo rm -f dldSmartgit.log*
echo "Obtaining SmartGit.."
wget -cNb --output-file=dldSmartgit.log ${LOCAL_MIRROR}/smartgit-generic-2_1_6.tar.gz
#
export SYNTEVO_HOME=${PRG}/com/syntevo
sudo mkdir -p ${SYNTEVO_HOME}
cd ${SYNTEVO_HOME}
echo "Expanding SmartGit.."
sudo tar zxvf ${INS}/smartgit-generic-2_1_6.tar.gz
echo "Symlinking SmartGit.."
sudo ln -s smartgit-2_1_6 smartgit
export SMARTGIT_HOME=${SYNTEVO_HOME}/smartgit
sudo chown -R yourself:yourself ${SYNTEVO_HOME}
#
exit 0;

echo "Creating panel button.."
#
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

