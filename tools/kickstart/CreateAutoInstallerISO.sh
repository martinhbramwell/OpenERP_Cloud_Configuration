cd ~/

if [ -f ./Downloads/ubuntu-11.10-server-amd64.iso ]; then
   echo "Found the ISO file."
else
   echo "ISO image not found";
   exit 1;
fi

echo "Mounting it."

sudo mkdir -p /mnt/isoMount
sudo mount -o loop /home/hasan/Downloads/ubuntu-11.10-server-amd64.iso /mnt/isoMount

if [ -f /mnt/isoMount/md5sum.txt ]; then
   echo "ISO file now mounted read-only."
else
   echo "ISO image did not mount";
   exit 1;
fi

SRV_CONFIG="https://raw.github.com/martinhbramwell/OpenERP_Cloud_Configuration/master"
KCKSTRT_DIR="/tools/kickstart"

echo "Making a read/write copy of the ISO"
mkdir -p ~/Desktop/Oneiric64Image
rm -fr ~/Desktop/Oneiric64Image
echo "Copying ..."
rsync -a /mnt/isoMount/ ~/Desktop/Oneiric64Image
sudo chmod -R 777 ~/Desktop/Oneiric64Image
if [ -f ~/Desktop/Oneiric64Image/md5sum.txt ]; then
   echo "Oneiric64Image Successfully Recorded.";
else
   echo "Could not copy ISO image.";
   exit 1;
fi


echo "Unmounting read-only image."
sudo umount /mnt/isoMount

if [ -f /mnt/isoMount/md5sum.txt ]; then
   echo "ISO image did not unmount successfully.";
   exit 1;
else
   echo "ISO file no longer mounted."
fi

echo "Adding our customizations"
rm -f ~/Desktop/Oneiric64Image/ks.cfg
wget -P ~/Desktop/Oneiric64Image/ $SRV_CONFIG$KCKSTRT_DIR/ks.cfg
if [ -f ~/Desktop/Oneiric64Image/ks.cfg ]; then
   echo "Kickstart config recorded."
else
   echo "Failed to get Kickstart config file.";
#   exit 1;
fi

rm -f ~/Desktop/Oneiric64Image/isolinux/txt.cfg.*
mv ~/Desktop/Oneiric64Image/isolinux/txt.cfg ~/Desktop/Oneiric64Image/isolinux/txt.cfg.original
wget -P ~/Desktop/Oneiric64Image/isolinux $SRV_CONFIG$KCKSTRT_DIR/txt.cfg
if [ -f ~/Desktop/Oneiric64Image/isolinux/txt.cfg ]; then
   echo "Kickstart menu recorded."
else
   echo "Failed to get Kickstart menu file.";
   exit 1;
fi

DSK_LABEL=“Ubu64b1110”
IMG_NAME=isolinux/isolinux.bin
IMG_CAT=isolinux/boot.cat
TARGET=~/Desktop/OneiricServer64_autoins.iso

echo "Creating new ISO image"
cd ~/Desktop/Oneiric64Image/
mkisofs -D -r -V "$DSK_LABEL" -cache-inodes -J -l -b $IMG_NAME -c $IMG_CAT \
  -no-emul-boot -boot-load-size 4 -boot-info-table -o $TARGET .

if [ -f "$TARGET" ]; then
   echo "*** $TARGET Successfully Recorded ***"
else
   echo "*** $TARGET Writing Failed ***";
   exit 1;
fi

exit 0;



