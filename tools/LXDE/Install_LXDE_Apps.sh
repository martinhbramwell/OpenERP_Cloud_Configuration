#! /bin/bash
# script to collect all my cloud DNS configuration into this directory.
#
export ADMIN_USERZ_UID=yourself
export ADMIN_USERZ_HOME=/home/$ADMIN_USERZ_UID
export ADMIN_USERZ_WORK_DIR=/home/$ADMIN_USERZ_UID/tmp
export USER_LOG=/home/$ADMIN_USERZ_UID/install2.log
mkdir -p $ADMIN_USERZ_WORK_DIR
#
export PANELS_CONFIG_DIR=$ADMIN_USERZ_HOME/.config/lxpanel
export X11_DIR=/LXDE
export X11_PANELS_CONFIG=$X11_DIR/config
export X11_PANELS_DIR=$X11_DIR/panels
export X11_TOP_PANEL=$X11_PANELS_DIR/top
export X11_MAIN_PANEL=$X11_PANELS_DIR/panel
#
echo "Installing gedit ..."
sudo aptitude -y install gedit
echo " "
echo " gedit Installed  "
#
# Initiate downloading the installers we're going to need.
LOCAL_MIRROR=http://openerpns.warehouseman.com/downloads
#
cd ${INS}
#
sudo rm -f dldLXDE_Tools.log*
echo "Obtaining LXDE Tools.."
# Obtain LXDE Tools
SRV_SOURCEFORGE="http://http://sourceforge.net/projects"
#wget -cNb --output-file=dldLXDE_Tools.log ${SRV_SOURCEFORGE}/lxde/files/latest/download?source=files
wget -cNb --output-file=dldLXDE_Tools.log ${LOCAL_MIRROR}/gpicview_0.2.2-1_amd64.deb
#
#
${PRG}/installTools/waitForCompleteDownload.sh -d 3600 -l ./dldLXDE_Tools.log -p gpicview_0.2.2
#
echo "LXDE tools Obtained. Installing LXShortcut ..."
#
sudo dpkg -i gpicview_0.2.2-1_amd64.deb
#
echo "LXShortcut Installed. Create a top panel if none exists ..."
#
mkdir -p $PANELS_CONFIG_DIR$X11_PANELS_DIR
cd $PANELS_CONFIG_DIR
#
if [ -f .$X11_MAIN_PANEL ]; then
   echo "Won't risk over-writing anything."
else
   if [ -f .$X11_PANELS_CONFIG ]; then
      echo "Won't over-write the config file."
   else
      echo "Get the config file."
      cd .$X11_DIR
      wget ${SRV_CONFIG}/tools$X11_PANELS_CONFIG
      echo "Got the config file."
   fi
   cd $PANELS_CONFIG_DIR
#
   if [ -f .$X11_TOP_PANEL ]; then
      echo "Won't over-write existing top panel."
   else
      echo "Get the panels."
      cd .$X11_PANELS_DIR
      wget ${SRV_CONFIG}/tools$X11_TOP_PANEL
      wget ${SRV_CONFIG}/tools$X11_MAIN_PANEL
      echo "Got the panels."
   fi
fi
#
#
echo "LXDE panels config obtained. Installing to default home ..."
cd $ADMIN_USERZ_WORK_DIR
#  mv .$X11_DIR $PANELS_CONFIG_DIR/
#
echo "LXDE panels installed. Can now be configured for newly installed application."	







    
