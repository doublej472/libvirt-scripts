#!/bin/sh
. ./config.sh

usage() {
	echo "$0 <name> <domain> <cpus> <memory> <disksize> <baseimage> <user> <MAC address>"
}

if [ $# -ne 8 ]; then
	usage
	return
fi

if [ ! -f ./create-local-config.sh ]; then
	echo "This script needs ./create-local-config.sh to run!"
	return
fi

if [ ! -f $6 ]; then
	echo "Can't find base image at $6!"
	usage
	return
fi

if [ -f $VMDIR/$1 ]; then
	echo "Refusing to overwrite image at $VMDIR/$1!"
	return
fi

qemu-img create -f qcow2 -F qcow2 -b $6 $VMDIR/$1.qcow2 $5
qemu-img resize $VMDIR/$1.qcow2 $5

./create-local-config.sh $1 $2 $7

# Manually copying images requies a pool refresh
virsh pool-refresh $VMPOOL

virt-install \
	-n $1 \
	--memory $4 \
	--vcpus $3 \
	--os-variant debian9 \
	--controller scsi,model=virtio-scsi \
	-w bridge=br0,model=virtio,mac=$8 \
	--disk vol=vms/$1.qcow2,bus=scsi,cache=directsync --import \
	--disk vol=vms/$1-cidata.iso,device=cdrom,bus=scsi,cache=directsync \
	--autostart --noautoconsole
