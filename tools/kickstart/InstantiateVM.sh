# mkdir -p ~/Desktop/var/kvm/images
# create a directory for virtual machines

source ./ConfigureVariables.sh

virsh -q destroy $VIRTUAL_MACHINE_NAME 2>/dev/null
virsh -q undefine $VIRTUAL_MACHINE_NAME 2>/dev/null

cd ~/Desktop
sudo virt-install \
--connect qemu:///system \
--name $VIRTUAL_MACHINE_NAME \
--ram $VIRTUAL_RAM_SIZE \
--disk path=$VIRTUAL_DISK_PATH/$VIRTUAL_DISK_NAME,size=$VIRTUAL_DISK_SIZE \
--network network=default,model=virtio \
--accelerate \
--vcpus=1 \
--os-type linux \
--os-variant=ubuntumaverick \
--cdrom $SOURCE_ISO

# --extra-args=preseed/file=/cdrom/preseed.cfg \






