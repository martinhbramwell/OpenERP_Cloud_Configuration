#!/bin/bash

echo "- - - - - - - - - - - - - - - - - - - - "
echo "Check we have one at all..."

if [ -f $ORIGINAL_IMAGE ]; then
   echo "Found the ISO file."
else
   echo "ISO image not found";
   exit 1;
fi

echo "- - - - - - - - - - - - - - - - - - - - "
echo "Mounting it."

sudo mkdir -p $TEMPORARY_MOUNT_POINT
sudo mount -o loop $ORIGINAL_IMAGE $TEMPORARY_MOUNT_POINT
if [ -f $TEMPORARY_MOUNT_POINT/md5sum.txt ]; then
   echo "ISO file now mounted read-only."
else
   echo "ISO image did not mount";
   exit 1;
fi


echo "- - - - - - - - - - - - - - - - - - - - "
echo "Making a read/write copy of the ISO"

mkdir -p $WORKING_IMAGE
sudo rm -fr $WORKING_IMAGE
echo "Copying ..."
rsync -a $TEMPORARY_MOUNT_POINT/ $WORKING_IMAGE
sudo chmod -R 777 $WORKING_IMAGE
if [ -f $WORKING_IMAGE/md5sum.txt ]; then
   echo "Oneiric64Image successfully copied.";
else
   echo "Could not copy ISO image.";
   exit 1;
fi


echo "- - - - - - - - - - - - - - - - - - - - "
echo "Unmounting read-only image."
sudo umount $TEMPORARY_MOUNT_POINT

if [ -f $TEMPORARY_MOUNT_POINT/md5sum.txt ]; then
   echo "ISO image did not unmount successfully.";
   exit 1;
else
   echo "ISO file no longer mounted."
fi

echo "= = = = = = = = = = = = = = = = = = = = "

