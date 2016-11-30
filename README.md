KVM config for a collapsed MAAS 2.0 Region/Rack Controller

##Networks

- maas

- bridge

- nat


##Virtual Machine definitions

- maas

- kvm1



## Problems & Resolutions

### PXE Failures:

- http://ipxe.org/err/040ee1

- IP assignment with no TFTP payload


### Juju bootstrap

- maas user not in libvirtd 

Provisioning via virsh as maas fails without membership in libvirtd

- lxd, kvm conflicts:

Virtual bridge namespace conflicts; auto-provisioned bridges virbr0, virbr1 when deploying lxd and maas collapsed

Run launchjujuvm.sh to provision node for 'juju bootstrap'


