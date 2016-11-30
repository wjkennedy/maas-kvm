#!/bin/bash
# wjkennedy
# Mon Nov 28 10:19:50 PST 2016
#
# Launch a KVM VM for Juju to discover.
# - Should be in the 'default' zone
# - Should use the named network exposed through MAAS with DHCP enabled
# - Uses a simple MAC, populate the new Node in MAAS with this address
# - Set to boot from the NIC on the 'external' network.
#
#  !!! Check/Edit networks/external.xml
#
################################################################################

virsh info juju

case $? in

	2)
		echo "Launching KVM VM for Juju..."		
		virt-install --name juju --ram 500 --disk path=/var/lib/libvirt/images/juju.img,size=2 --network network:external,mac=00:00:00:00:00:ea --accelerate --pxe
	;;

	*)
		echo "Creating External network,,,"
		virsh net-create networks/external.xml

		echo "Attempting to launch Juju Controller VM"
		virsh create /etc/libvirt/qemu/juju.xml
		
		echo "Serial console defined at:"
		virsh ttyconsole juju

	;;
esac
