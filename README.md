KVM config for a collapsed MAAS 2.0 Region/Rack Controller

![](maas-juju-net.png)

##Networks


 Name                 State      Autostart     Persistent
----------------------------------------------------------
 default              active     yes           yes
 external             active     yes           yes
 isolated             active     yes           yes
 maas                 active     yes           yes

##Deploy

Run environment.sh to provision the network and vms for MAAS/Juju bootstrap


## Problems & Resolutions

### PXE Failures:

- http://ipxe.org/err/040ee1

- IP assignment with no TFTP payload

Check network, bridging.

### No TFTP payload:

- Boots on MAAS network, receives IP address from MAAS, no TFTP payload delivered.

Check that image download has completed successfully.

Run tcpdump on MAAS network interface as defined with 'dpkg-reconfigure maas-region-controller', check for IP assignment.

(How to discover TFTP behavior)


### Juju bootstrap

- maas user not in libvirtd 

Provisioning via virsh as maas fails without membership in libvirtd

- lxd, kvm conflicts:

Virtual bridge namespace conflicts; auto-provisioned bridges virbr0, virbr1 when deploying lxd and maas collapsed

Run launchjujuvm.sh to provision node for 'juju bootstrap'


# Virsh/Qemu Errors

* Cannot connect to qemu:/// URI from MAAS
* Cannot connect to qemu:/// URI as 'maas' user
* Error in MAAS: Failed to login to virsh console
* Errors in /var/log/maas/maas.log - Marking node failed: Node could not be powered on: Failed talking to node's BMC: Failed to login to virsh console. 


## Testing

### maas user identities

* user, group permissions

Check for membership in 'libvirtd' group:

    libvirtd:x:129: maas
* file permissions /var/run/libvirt/libvirt-sock:

    **srwxrwx--- 1 root libvirtd **0 Nov 10 15:05 /var/run/libvirt/libvirt-sock

## Forensics

Connect to qemu:///system as maas user:

    virsh connect qemu:///system

Running virsh list:

	error: failed to connect to the hypervisor
	error: no valid connection
	error: Failed to connect socket to '/var/run/libvirt/libvirt-sock': Permission denied
	




