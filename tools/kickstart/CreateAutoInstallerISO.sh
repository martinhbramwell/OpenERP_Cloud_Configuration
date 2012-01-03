# These may be replaced by  ConfigureVariables.sh  below !!
export KCKSTRT_DIR=/tools/kickstart
export TOOLS_DIR=/home/hasan/projects/OpenERP_Cloud_Configuration$KCKSTRT_DIR
export WORKING_DIR=~/Desktop/ISOwork
# These may be replaced by  ConfigureVariables.sh  below !!


mkdir -p $WORKING_DIR
cd $WORKING_DIR

echo "Getting the sudo stuff out of the way."
sudo pwd

#
#
# These may replace the three variables set at the top !!
echo "Getting the other scripts."
cp $TOOLS_DIR/GetRequiredFiles.sh .
./GetRequiredFiles.sh
#
echo "Making all the variables available to all the scripts."
source ./ConfigureVariables.sh
# These may replace the three variables set at the top !!
#
#
if [ 1 = 1 ]; then

	echo "Exposing the target location"
	./Unpack_UbunutuInstallerISO.sh
	./Unpack_Initrd.sh
 	if [ 1 = 1 ]; then
		####################      Begin installer customization       ###############
		#                                                                           #
		echo "Adding our customizations"
		mv $REPLACEMENT_SEED_FILE $SEED_FILE_TEMPORARY_HOME/$TARGET_SEED_FILE
		mv $REPLACEMENT_BOOTLOADER $BOOTLOADER_TEMPORARY_HOME/$ORIGINAL_BOOTLOADER
		#                                                                           #
		####################     End of installer customization       ###############
	fi

	echo "Restore ownership to root"
	sudo chown -R root:root $WORKING_IMAGE

	echo "Close up the target location"
	./Repack_Initrd.sh
	./Repack_UbunutuInstallerISO.sh

fi

echo "Instantiate the new VM"
./InstantiateVM.sh


if [ 0 = 1 ]; then

	exit 0;

	cd $WORKING_DIR/..
	rm -fr $WORKING_DIR

fi


