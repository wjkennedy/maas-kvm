#!/bin/bash
# Sun Nov 27 18:30:28 PST 2016
#
##################################################################

echo "Creating KVM virtual networks.."

# "External" network
virsh net-create networks/external.xml
virsh net-info external

# MAAS network
virsh net-create networks/maas.xml
virsh net-info maas

echo "Creating VM for Juju.."
virt-install --name juju --ram 500 --disk path=/var/lib/libvirt/images/juju.img,size=2 -f qcow2 --network network:virbr0,mac=00:00:00:00:00:ea --accelerate --pxe
