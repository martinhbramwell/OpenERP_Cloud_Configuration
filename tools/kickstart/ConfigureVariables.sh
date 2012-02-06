#!/bin/bash

export KCKSTRT_DIR=/tools/kickstart
export TOOLS_DIR=/home/hasan/projects/OpenERP_Cloud_Configuration$KCKSTRT_DIR
export WORKING_DIR=~/Desktop/ISOwork

# Characteristics of the final target VM
export VIRTUAL_MACHINE_NAME=Oneiric64ExpVM_tmp
export VIRTUAL_RAM_SIZE=1024
# export VIRTUAL_MACHINE_NAME=Oneiric64ExpVM
# export VIRTUAL_RAM_SIZE=512

export VIRTUAL_DISK_NAME=OO64ExpVDK_tmp
export VIRTUAL_DISK_PATH=/var/lib/libvirt/images
export VIRTUAL_DISK_SIZE=6
# export VIRTUAL_DISK_NAME=OO64ExpVDK
# export VIRTUAL_DISK_PATH=/var/lib/libvirt/images
#export VIRTUAL_DISK_SIZE=4

export WORKING_IMAGE=$WORKING_DIR/Oneiric64Image
# export WORKING_IMAGE=$WORKING_DIR/Oneiric64Image

export ORIGINAL_IMAGE_LOCATION=~/Downloads
# export ORIGINAL_IMAGE_LOCATION=~/Downloads
export ORIGINAL_IMAGE_NAME=ubuntu-11.10-server-amd64.iso
# export ORIGINAL_IMAGE_NAME=ubuntu-11.10-server-amd64.iso
export ORIGINAL_IMAGE=$ORIGINAL_IMAGE_LOCATION/$ORIGINAL_IMAGE_NAME

export TEMPORARY_MOUNT_POINT=/mnt/isoMount


export SERVER_INSTALLER_VERSION=server
export DESKTOP_INSTALLER_VERSION=desktop
#  * * * Uncommment only one * * * 
#export INSTALLER_VERSION=$SERVER_INSTALLER_VERSION  
export INSTALLER_VERSION=$DESKTOP_INSTALLER_VERSION
#  * * * * * * * * * * * * * * * * 
export SEED_FILE_DIR=""
export SEED_FILE_NAME=""
export INITIAL_RAMDISK_NAME=""
export REPLACEMENT_BOOTLOADER=""

# if [ "$INSTALLER_VERSION" == "$DESKTOP_INSTALLER_VERSION" ]; then
# 	echo "Installing Ubuntu Desktop";
# 	SEED_FILE_DIR=casper
# 	INITIAL_RAMDISK_NAME=initrd.lz
# 	REPLACEMENT_BOOTLOADER=fullyAutomatic_isolinux_desktop.cfg
# else
	echo "Installing Ubuntu Server";
	SEED_FILE_DIR=install
	INITIAL_RAMDISK_NAME=initrd.gz
	REPLACEMENT_BOOTLOADER=fullyAutomatic_isolinux.cfg
# fi

export INITIAL_RAMDISK_LOCATION=$WORKING_IMAGE/$SEED_FILE_DIR
export INITIAL_RAMDISK=$INITIAL_RAMDISK_LOCATION/$INITIAL_RAMDISK_NAME

export ORIGINAL_BOOTLOADER=isolinux.cfg
export BOOTLOADER_TEMPORARY_HOME=$WORKING_IMAGE/isolinux

export TARGET_SEED_FILE=preseed.cfg

export SEED_FILE_TEMPORARY_HOME=$INITIAL_RAMDISK_LOCATION/initrd.unpacked

export FINAL_STAGE_CONFIGURATION=InitialBootConfigurations.sh

export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"

export VIRTINSTALL_MAJORVERSION=0.600.0
export VIRTINSTALL_MINORVERSION="-2"
export VIRTINSTALL_VERSION=$VIRTINSTALL_MAJORVERSION$VIRTINSTALL_MINORVERSION

export VIRTMANAGER_MAJORVERSION=0.9.0
export VIRTMANAGER_MINORVERSION="-2"
export VIRTMANAGER_VERSION=$VIRTMANAGER_MAJORVERSION$VIRTMANAGER_MINORVERSION

export VIRTINST_PKG="virtinst_$VIRTINSTALL_VERSION~natty1_all.deb"
export VIRTMAN_PKG="virt-manager_$VIRTMANAGER_VERSION~natty1_all.deb"
export VIRTMANAGER_TEAM_SITE=https://launchpad.net/~ukplc-team/+archive/ppa/+files/


export DSK_LABEL=“Ubu64b1110”
export IMG_NAME=isolinux/isolinux.bin
export IMG_CAT=isolinux/boot.cat

export TARGET_ISO=OneiricServer64_autoins.iso
export FINAL_DESTINATION=~/Desktop
export TARGET=$FINAL_DESTINATION/$TARGET_ISO

#export INSTALL_MEDIA_REPO=~/Desktop
#export VM_INSTALL_MEDIA=OneiricServer64_autoins.iso
export INSTALL_MEDIA_REPO=$FINAL_DESTINATION
export VM_INSTALL_MEDIA=$TARGET_ISO
export SOURCE_ISO=$INSTALL_MEDIA_REPO/$VM_INSTALL_MEDIA


export REPLACEMENT_SEED_FILE=Oneiric64-minimalvm_dktp.seed
# export REPLACEMENT_SEED_FILE=Oneiric64-minimalvm.seed

#export REPLACEMENT_SEED_FILE=Oneiric64-server.seed # Resulting disk usage :: 0000 Mb
# Language : English <Enter>
# Territory : US <Enter>
# Detect keyboard : yes/no <Enter>
# Keyboard country : Sp (Lat Am)
# Keyboard layout : Sp (Lat Am - __) <Enter>
# Net - Hostname : "Continuous" <Enter>
# Clock - time zone correct? <Enter>
# Partitioner - Guided, full disk <Down> <Enter>
# Disk to partition - <Enter>
# Partitioner - Remove existing - <Yes>
# Partitioner - Write and configure - <Yes>
# Partitioner - Amount to use - <Enter>
# Partitioner - Write and continue - <Yes>
# User full name : "Me" <Enter>
# User name : <Enter>
# Pass 1 - "okok" <Enter>
# Pass 2 - "okok" <Enter>
# Weak ? <Yes>
# Encrypt dir Yes / no : <Enter>
# APT proxy : "http://192.168.122.10:3142" <Enter>
# Manage upgrades : Install security ... <Enter>
# Extra language support Yes/no? <No>
# Choose software to install : OpenSSH <Enter>
# Install GRUB? <Enter>
# Set UTC clock <Enter>
# Finish up? <Enter>

# export REPLACEMENT_SEED_FILE=Oneiric64-server-minimal.seed # Resulting disk usage :: 876 Mb
# Language : English <Enter>
# Territory : US <Enter>
# Detect keyboard : yes/no <Enter>
# Keyboard country : Sp (Lat Am)
# Keyboard layout : Sp (Lat Am - __) <Enter>
# Net - Hostname : "Continuous" <Enter>
# Clock - time zone correct? <Enter>
# Partitioner - Guided, full disk, LVM <Enter>
# Disk to partition - <Enter>
# Partitioner - Remove existing - <Yes>
# Partitioner - Write and configure - <Yes>
# Partitioner - Amount to use - <Enter>
# Partitioner - Write and continue - <Yes>
# User full name : "Me" <Enter>
# User name : <Enter>
# Pass 1 - "okok" <Enter>
# Pass 2 - "okok" <Enter>
# Weak ? <Yes>
# Encrypt dir Yes / no : <Enter>
# APT proxy : "http://192.168.122.10:3142" <Enter>
# Manage upgrades : Install security ... <Enter>
# Choose software to install : OpenSSH <Enter>
# Install GRUB? <Enter>
# Finish up? <Enter>




