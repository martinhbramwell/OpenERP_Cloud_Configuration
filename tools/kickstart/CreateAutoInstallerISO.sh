# These may be replaced by  ConfigureVariables.sh  below !!
export KCKSTRT_DIR=/tools/kickstart
export TOOLS_DIR=/home/hasan/projects/OpenERP_Cloud_Configuration$KCKSTRT_DIR
export WORKING_DIR=~/Desktop/ISOwork
# These may be replaced by  ConfigureVariables.sh  below !!


mkdir -p $WORKING_DIR
cd $WORKING_DIR

echo "Get the sudo stuff out of the way."
sudo pwd

cp $TOOLS_DIR/GetRequiredFiles.sh .
./GetRequiredFiles.sh


# These may replace the three variables set at the top !!
source ./ConfigureVariables.sh
# These may replace the three variables set at the top !!

echo "Exposing the target location"
./Unpack_UbunutuInstallerISO.sh
./Unpack_Initrd.sh

# if [ 0 = 1 ]; then
# fi


echo "Adding our customizations"
mv $REPLACEMENT_SEED_FILE $SEED_FILE_TEMPORARY_HOME/$TARGET_SEED_FILE
mv $REPLACEMENT_BOOTLOADER $BOOTLOADER_TEMPORARY_HOME/$ORIGINAL_BOOTLOADER

echo "Restore ownership to root"
sudo chown -R root:root $WORKING_IMAGE

echo "Close up the target location"
./Repack_Initrd.sh
./Repack_UbunutuInstallerISO.sh

echo "Instantiate the new VM"
./InstantiateVM.sh


if [ 0 = 1 ]; then

	exit 0;

	cd $WORKING_DIR/..
	rm -fr $WORKING_DIR

fi


