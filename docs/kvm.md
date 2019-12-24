### Get list of `os-variants` valid for KVM
```bash
ldumont@kvm01:~$ osinfo-query os | grep -i centos
centos6.0            | CentOS 6.0                                         | 6.0      | http://centos.org/centos/6.0            
centos6.1            | CentOS 6.1                                         | 6.1      | http://centos.org/centos/6.1            
centos6.10           | CentOS 6.10                                        | 6.10     | http://centos.org/centos/6.10           
centos6.2            | CentOS 6.2                                         | 6.2      | http://centos.org/centos/6.2            
centos6.3            | CentOS 6.3                                         | 6.3      | http://centos.org/centos/6.3            
centos6.4            | CentOS 6.4                                         | 6.4      | http://centos.org/centos/6.4            
centos6.5            | CentOS 6.5                                         | 6.5      | http://centos.org/centos/6.5            
centos6.6            | CentOS 6.6                                         | 6.6      | http://centos.org/centos/6.6            
centos6.7            | CentOS 6.7                                         | 6.7      | http://centos.org/centos/6.7            
centos6.8            | CentOS 6.8                                         | 6.8      | http://centos.org/centos/6.8            
centos6.9            | CentOS 6.9                                         | 6.9      | http://centos.org/centos/6.9            
centos7.0            | CentOS 7.0                                         | 7.0      | http://centos.org/centos/7.0          
```

### Create PXE only virsh domain

```shell
sudo virt-install --name test-ubuntu \
--ram 4096 --vcpus 2 \
--disk path=/var/lib/libvirt/images/test-ubuntu,bus=virtio,size=50 \
--noautoconsole --graphics vnc \
--cdrom=/var/lib/libvirt/boot/mini.iso \
--network bridge:br0 \
--network bridge:br1 \
--os-variant ubuntu18.04

sudo virt-install --name ooo-director \
--ram 18432 --vcpus 4 \
--disk path=/var/lib/libvirt/images/ooo-director,bus=virtio,size=50 \
--noautoconsole --graphics vnc \
--cdrom=/var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-1908.iso \
--network bridge:br0 \
--network bridge:br1 \
--os-variant centos7.0

sudo virt-install --name ooo-controller001 \
--ram 18432 --vcpus 4 \
--disk path=/var/lib/libvirt/images/ooo-controller001.qcow2,bus=virtio,size=50 \
--pxe --noautoconsole --graphics vnc --hvm \
--network bridge:br0 \
--network bridge:br1 \
--os-variant centos7.0

sudo virt-install --name ooo-controller002 \
--ram 18432 --vcpus 4 \
--disk path=/var/lib/libvirt/images/ooo-controller002.qcow2,bus=virtio,size=50 \
--pxe --noautoconsole --graphics vnc --hvm \
--network bridge:br0 \
--network bridge:br1 \
--os-variant centos7.0

sudo virt-install --name ooo-controller003 \
--ram 18432 --vcpus 4 \
--disk path=/var/lib/libvirt/images/ooo-controller003,bus=virtio,size=50 \  
--pxe --noautoconsole --graphics vnc --hvm \
--network bridge:br0 \
--network bridge:br1 \
--os-variant centos7.0

sudo virt-install --name ooo-compute001 \
--ram 18432 --vcpus 4 \
--disk path=/var/lib/libvirt/images/ooo-compute001,bus=virtio,size=50 \
--pxe --noautoconsole --graphics vnc --hvm \
--network bridge:br0 \
--network bridge:br1 \
--os-variant centos7.0
```

### Bridge physical interface for VM access.
```
#Install the bridge-utils package
apt-get install bridge-utils

#Create the two bridges
brctl addbr br1
brctl addbr br2
```

```shell
# In /etc/network/interfaces
# Use old eth0 config for br0, plus bridge stuff

#loopback
auto lo
iface lo inet loopback

auto br0
auto br1

iface br0 inet static
    address 10.10.99.62
    gateway 10.10.99.1
    netmask 255.255.255.0
    dns-nameservers 10.10.99.1 
    dns-search cmaker.studio
    bridge_ports    ens18
    bridge_stp      off
    bridge_maxwait  0
    bridge_fd       0

iface br1 inet manual
    bridge_ports    ens19
    bridge_stp      off
    bridge_maxwait  0
    bridge_fd       0

```

### Show VNC information - port is 590$(VNCDISPLAY_INDEX)
```
root@kvm01:~# virsh vncdisplay ooo-controller001
:0

root@kvm01:~# virsh vncdisplay ooo-controller002
:1

root@kvm01:~# virsh vncdisplay ooo-controller003
:2

root@kvm01:~# netstat -punta | grep 590
tcp        0      0 0.0.0.0:5902            0.0.0.0:*               LISTEN      2691/qemu-system-x8 
tcp        0      0 0.0.0.0:5900            0.0.0.0:*               LISTEN      2559/qemu-system-x8 
tcp        0      0 0.0.0.0:5901            0.0.0.0:*               LISTEN      2649/qemu-system-x8 
```

### VBMC
```
/opt/vbmc/bin/vbmc add ooo-controller001 --port 16001 --username test --password secret
/opt/vbmc/bin/vbmc add ooo-controller002 --port 16002 --username test --password secret
/opt/vbmc/bin/vbmc add ooo-controller003 --port 16003 --username test --password secret
sudo /opt/vbmc/bin/vbmc add ooo-compute001 --port 16004 --username test --password secret

/opt/vbmc/bin/vbmc start ooo-controller001
/opt/vbmc/bin/vbmc start ooo-controller002
/opt/vbmc/bin/vbmc start ooo-controller003
/opt/vbmc/bin/vbmc start ooo-compute001
```

### Enable serial connection over virsh
```shell
#FROM THE GUEST VM
sudo systemctl enable serial-getty@ttyS0.service
sudo systemctl start serial-getty@ttyS0.service
```

```shell
#FROM THE KVM HOST
sudo virsh console $DOMAIN_NAME
#OR GET THE DOMAIN ID from `virsh list`
sudo virsh console $KVM_DOMAIN_ID
```
