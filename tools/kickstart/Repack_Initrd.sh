cd ~/

echo "- - - - - - - - - - - - - - - - - - - - "
echo "Check we have a modified initrd ..."
if [ -f $SEED_FILE_TEMPORARY_HOME/preseed.cfg ]; then
   echo "A modified initrd is ready to repack.";
else
   echo "No initrd could be found where expected.";
   exit 1;
fi

echo "- - - - - - - - - - - - - - - - - - - - "
echo "Recompress the init.rd"

cd $SEED_FILE_TEMPORARY_HOME
find . | cpio -o --format=newc | gzip -9 > $INITIAL_RAMDISK
cd ..
sudo rm -rf $SEED_FILE_TEMPORARY_HOME

echo "= = = = = = = = = = = = = = = = = = = = "

