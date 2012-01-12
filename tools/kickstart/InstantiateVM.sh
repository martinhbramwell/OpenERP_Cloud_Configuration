# mkdir -p ~/Desktop/var/kvm/images
# create a directory for virtual machines

source ./ConfigureVariables.sh

export VIRTMANAGER_TEAM_SITE=https://launchpad.net/~ukplc-team/+archive/ppa/+files/
export VIRTINST_PKG=virtinst_0.600.0-2~natty1_all.deb
export VIRTMAN_PKG=virt-manager_0.9.0-2~natty1_all.deb

mkdir -p ~/temp
#
echo " "
echo " "
echo " Get a new virt-install if necessary. "
echo " "
LOCAL_VERSION=$( virt-install --version )
VIRTINST_LOCAL_VERSION=$( echo "$LOCAL_VERSION" | sed 's|0\.||' )
VIRT_VERSION=$( echo "$VIRTINSTALL_MAJORVERSION" | sed 's|0\.||' )
RSLT=$( echo " $VIRT_VERSION - $VIRTINST_LOCAL_VERSION " | bc )
echo "Required : $VIRTINSTALL_MAJORVERSION vs. Actual $LOCAL_VERSION "
if [ $RSLT != 0 ]; 
	then
		echo " * * * Warning : These scripts weren't tested with virt-install below version $VIRTINSTALL_VERSION * * * "; 
		cd ~/temp
		wget  -cN $VIRTMANAGER_TEAM_SITE$VIRTINST_PKG
		#
		sudo dpkg -i $VIRTINST_PKG
		cd ~/
		echo "Done."
        else
		echo "... Not necessary."
fi
#
echo " "
echo " "
echo " Get a new virt-manager if necessary. "
echo " "

LOCAL_VERSION=$( virt-manager --version )
VIRTMAN_LOCAL_VERSION=$( echo "$LOCAL_VERSION" | sed 's|0\.||' )
VIRT_VERSION=$( echo "$VIRTMANAGER_MAJORVERSION" | sed 's|0\.||' )
RSLT=$( echo " $VIRT_VERSION - $VIRTMAN_LOCAL_VERSION " | bc )
echo "Required : $VIRTMANAGER_MAJORVERSION vs. Actual $LOCAL_VERSION "
if [ $RSLT != 0 ]; 
	then
		echo " * * * Warning : These scripts weren't tested with virt-install below version $VIRTMANAGER_MAJORVERSION * * * "; 
		cd ~/temp
		wget  -cN $VIRTMANAGER_VERSION$VIRTMAN_PKG
		#
		sudo dpkg -i $VIRTMAN_PKG
		cd ~/
		echo "Done."
        else
		echo "... Not necessary."
fi
#
echo "- - - - - - - - - - - - - - - - - - - - "
echo "Removing any prior $VIRTUAL_MACHINE_NAME virtual machine ..."

#
virsh -q destroy $VIRTUAL_MACHINE_NAME 2>/dev/null
virsh -q undefine $VIRTUAL_MACHINE_NAME 2>/dev/null


echo "- - - - - - - - - - - - - - - - - - - - "
echo "... and building a new $VIRTUAL_MACHINE_NAME virtual machine."
cd ~/Desktop
sudo virt-install \
--connect qemu:///system \
--name $VIRTUAL_MACHINE_NAME \
--ram $VIRTUAL_RAM_SIZE \
--disk path=$VIRTUAL_DISK_PATH/$VIRTUAL_DISK_NAME,size=$VIRTUAL_DISK_SIZE,bus=virtio \
--network network=default,model=virtio \
--keymap=none \
--accelerate \
--vcpus=1 \
--video=vmvga \
--os-type linux \
--os-variant=ubuntumaverick \
--cdrom $SOURCE_ISO

echo "= = = = = = = = = = = = = = = = = = = = "

