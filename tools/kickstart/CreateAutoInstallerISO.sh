cd ~/

if [ -f "./Downloads/ubuntu-11.10-server-amd64.iso" ]; then
   echo "Found the ISO file."
else
   echo "ISO image not found";
   exit 1;
fi

echo "Mounting it."

sudo mkdir -p /mnt/isoMount
sudo mount -o loop /home/hasan/Downloads/ubuntu-11.10-server-amd64.iso /mnt/isoMount

if [ -f "/mnt/isoMount/md5sum.txt" ]; then
   echo "ISO file now mounted read-only."
else
   echo "ISO image did not mount";
   exit 1;
fi

echo "Making a read/write copy of the ISO"
mkdir -p ~/Desktop/Oneiric64Image
rm -fr ~/Desktop/Oneiric64Image
echo "Copying ..."
rsync -a /mnt/isoMount/ ~/Desktop/Oneiric64Image
sudo chmod -R 777 ~/Desktop/Oneiric64Image

echo "Unmounting read-only image."
sudo umount /mnt/isoMount

if [ -f "/mnt/isoMount/md5sum.txt" ]; then
   echo "ISO image did not unmount successfully.";
   exit 1;
else
   echo "ISO file no longer mounted."
fi

