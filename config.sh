# Where your qcow2 vm images are located
VMDIR=/data/vms
# The storage pool that VMDIR points to
VMPOOL=vmstorage
# The network bridge that your VMs are connected to
VMBRIDGE=br0
# The os-variant set when creating VMs
OSVARIANT=debian9
# The user and group that VM images are given
VMUSER=qemu
VMGROUP=libvirt
