echo "- - - - - - - - - - - - - - - - - - - - "
echo "Check we have an editable ISO image at $INITIAL_RAMDISK ..."
if [ -f $INITIAL_RAMDISK ]; then
   echo "An initrd is available for editing.";
else
   echo "No initrd could be found where expected.";
   exit 1;
fi

echo "- - - - - - - - - - - - - - - - - - - - "
echo "Decompress the init.rd"

mkdir -p $SEED_FILE_TEMPORARY_HOME
cd $SEED_FILE_TEMPORARY_HOME
gunzip <../$INITIAL_RAMDISK_NAME | sudo cpio -i

echo "= = = = = = = = = = = = = = = = = = = = "

