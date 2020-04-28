#!/bin/sh
# $1 = VM name
. ./config.sh

usage() {
	echo "$0 <name>"
}

if [ $# -ne 1 ]; then
	usage
	exit 1
fi

if [ -z "$(virsh list --all --name | grep ^$1\$)" ]
then
	echo "Can't find VM $1!"
	exit 2
fi

read -p "Are you sure you want to delete VM $1? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo
	virsh destroy $1
	virsh undefine $1
	virsh vol-delete --pool "$VMPOOL" "$1.qcow2"
	virsh vol-delete --pool "$VMPOOL" "$1-cidata.iso"
fi
