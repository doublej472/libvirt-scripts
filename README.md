# libvirt-scripts

This is a collection of scripts I use to manage my libvirt cluster, feel free
to use them however you wish, no warranty given or implied. These scripts make
some assumptions about your configuration, but you can configure most options
in the ``config.sh`` file.

Your public SSH keys should be added to the ``ssh-keys`` directory, otherwise
you won't be able to login to your VMs

[Also, I made a post about this on my
blog!](https://blog.doublej472.com/post/libvirt-cluster/)

``create-vm.sh``
----------------

Defines and starts a VM on the local computer by talking to the libvirt daemon.
This script takes a whole bunch of arguments, in this order:

1. VM hostname (w/o domain)
2. VM network domain
3. Number of CPUs
4. RAM in megabytes
5. Hard disk size in gigabytes
6. Path to base image
7. User to create on VM
8. MAC address (See ``gen-mac-address.sh``)

This script will call ``create-local-config.sh`` to create an ISO file that will
be used by [cloud-init](https://cloud-init.io/) on the VM base image for
provisioning.

``create-local-config.sh``
--------------------------

Creates a ISO file that can be used by the
[NoCloud](https://cloudinit.readthedocs.io/en/latest/topics/datasources/nocloud.html)
backend datasource for [cloud-init](https://cloud-init.io/). Takes 3 arguments,
the VM name (without domain), the VM domain (if you don't have one, just make
something up), and the username that will be associated with your SSH key.


``gen-mac-address.sh``
----------------------

Generates a semi-random MAC address starting with 52:54:00. Useful if you want
to define a bunch of MAC addresses ahead of time, or if you want to define
static DHCP leases on your DHCP server.

``config.sh``
-------------

Not an actual script, this exports some variables that will be used for some of
the scripts above. Normally you should only need to edit this file for your
configuration.
