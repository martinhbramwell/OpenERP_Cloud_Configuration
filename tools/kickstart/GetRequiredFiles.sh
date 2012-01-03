## ======================================

echo "Getting ConfigureVariables.sh"
cp $TOOLS_DIR/ConfigureVariables.sh .
chmod +x ConfigureVariables.sh

source ./ConfigureVariables.sh

echo "Getting Unpack_UbuntuInstallerISO.sh"
cp $TOOLS_DIR/Unpack_UbuntuInstallerISO.sh .
chmod +x Unpack_UbuntuInstallerISO.sh
#
echo "Getting Unpack_Initrd.sh"
cp $TOOLS_DIR/Unpack_Initrd.sh .
chmod +x Unpack_Initrd.sh

echo "Getting Repack_Initrd.sh"
cp $TOOLS_DIR/Repack_Initrd.sh .
chmod +x Repack_Initrd.sh
#
echo "Getting Repack_UbuntuInstallerISO.sh"
cp $TOOLS_DIR/Repack_UbuntuInstallerISO.sh .
chmod +x Repack_UbuntuInstallerISO.sh
#
echo "Getting InstantiateVM.sh"
cp $TOOLS_DIR/InstantiateVM.sh .
chmod +x InstantiateVM.sh

echo "Getting InitialBootConfigurations.sh"
cp $TOOLS_DIR/InitialBootConfigurations.sh .
chmod +x InitialBootConfigurations.sh

## ======================================

rm -f $REPLACEMENT_SEED_FILE
cp $TOOLS_DIR/$REPLACEMENT_SEED_FILE .
# wget $SRV_CONFIG$KCKSTRT_DIR/$REPLACEMENT_SEED_FILE
if [ -f $REPLACEMENT_SEED_FILE ]; then
   echo "Obtained new preseed file $REPLACEMENT_SEED_FILE."
else
   echo "Failed to get preseed file.";
   exit 1;
fi


rm -f $REPLACEMENT_BOOTLOADER
cp $TOOLS_DIR/$REPLACEMENT_BOOTLOADER .
# wget $SRV_CONFIG$KCKSTRT_DIR/$REPLACEMENT_BOOTLOADER
if [ -f $REPLACEMENT_BOOTLOADER ]; then
   echo "Obtained new bootloader $ORIGINAL_BOOTLOADER."
else
   echo "Failed to get $REPLACEMENT_BOOTLOADER file.";
   exit 1;
fi

## ======================================

