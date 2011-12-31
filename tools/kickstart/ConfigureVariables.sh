export WORKING_DIR=~/Desktop/ISOwork
export WORKING_IMAGE=$WORKING_DIR/Oneiric64Image

export ORIGINAL_IMAGE_LOCATION=~/Downloads
export ORIGINAL_IMAGE_NAME=ubuntu-11.10-server-amd64.iso
export ORIGINAL_IMAGE=$ORIGINAL_IMAGE_LOCATION/$ORIGINAL_IMAGE_NAME

export TEMPORARY_MOUNT_POINT=/mnt/isoMount

export INITIAL_RAMDISK_LOCATION=$WORKING_IMAGE/install
export INITIAL_RAMDISK_NAME=initrd.gz
export INITIAL_RAMDISK=$INITIAL_RAMDISK_LOCATION/$INITIAL_RAMDISK_NAME

export ORIGINAL_BOOTLOADER=isolinux.cfg
export REPLACEMENT_BOOTLOADER=fullyAutomatic_isolinux.cfg
export BOOTLOADER_TEMPORARY_HOME=$WORKING_IMAGE/isolinux

export TARGET_SEED_FILE=preseed.cfg
export REPLACEMENT_SEED_FILE=Oneiric64-minimalvm.seed
export SEED_FILE_TEMPORARY_HOME=$WORKING_IMAGE/install/initrd.unpacked

export SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
export KCKSTRT_DIR=/tools/kickstart

export TOOLS_DIR=/home/hasan/projects/OpenERP_Cloud_Configuration$KCKSTRT_DIR

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

export VIRTUAL_MACHINE_NAME=Oneiric64ExpVM
export VIRTUAL_RAM_SIZE=512

export VIRTUAL_DISK_NAME=OO64ExpVDK
export VIRTUAL_DISK_PATH=/var/lib/libvirt/images
export VIRTUAL_DISK_SIZE=4

