#!/bin/sh
. ./config.sh

TMPDIR=/tmp/create-local-config-$$

usage() {
	echo "$0 <name> <domain> <user>"
}

if [ $# -ne 3 ]; then
	usage
	return 1
fi

rm -rf $TMPDIR
mkdir -p $TMPDIR
cd $TMPDIR

cat > user-data <<EOF
#cloud-config
users:
  - name: $3
    ssh_authorized_keys:
    - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErW38CaIelX4UxWViJviTUBl13JUyX3vWXj8jM0+Gpv root@jump.doublej472.bak
    - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSPehBOR9d26+KPNGUYl5SReamcPuGZrNM7BQcpHOqm ansible@ansible-control
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
EOF

cat > meta-data <<EOF
instance-id: $1
local-hostname: $1.$2
EOF

genisoimage -output $VMDIR/$1-cidata.iso -volid cidata -joliet -rock user-data meta-data
virsh pool-refresh $VMPOOL
