**Rancid - Check which devices are impacted**
```shell
sort var/logs/VPN.20180109.070410  | grep -i key | uniq
```

**Rancid - Only show the device name to pipe into ssh-keygen**
```
sort var/logs/VPN.20180109.070410  | grep -i key | uniq | grep -Eo '^[^ ]+'
```

```
sort /opt/rancid/var/logs/VPN.20180111.064300  | grep -i key | uniq | grep -Eo '^[^ ]+'
```

**SSH - Remove the public keys**
```
ssh-keygen -f "/opt/rancid/.ssh/known_hosts" -R ###REMOTE_IP_OF_DEVICE###
```

**BIND DNS - Check the master zones (not ARPA or random files ) we are hosting**
```
ls -alh --ignore=*.arpa* | wc -
```

**SMART HD Data - Get useful smartctl data**
```
sudo smartctl -a /dev/sdb | egrep "Spin_Up_Time|Reallocated_Sector_Ct|Temperature|Current_Pending_Sector|Offline_Uncorrectable|Power_On_Hours"
```

**Network - Create TAP Interface**
```
tunctl -t tap0
ifconfig tap0 10.1.1.100 netmask 255.255.255.0 up
```

**Start Linux stress test**
```
screen -S stress-test -d -m stress --cpu 100 --io 100 --vm 20 --vm-bytes 1G --hdd 5 --timeout 24h
```

**Install markdown-pdf**
```
sudo npm install -g phantomjs --unsafe-perm
sudo npm install -g markdown-pdf --unsafe-perm
```

Debug Radius, FreeIPA, LDAP
```
radiusd -X 2>&1 | tee debugfile

tail -f /var/log/dirsrv/slapd-EVENT-DHMTL-CA/access

radtest ldumont user_ldap_password 10.0.99.22 1812 shared_radius_secret

ldapwhoami -vvv -h 10.0.99.22 -p 389 -D uid=ldumont,cn=users,cn=accounts,dc=event,dc=dhmtl,dc=ca -x -w user_ldap_password

```

### When Windows 10 Creator upgrade breaks Linux Grub
```
set root=(hd0,msdos5)
set prefix=(hd0,msdos5)/boot/grub
insmod normal
normal
```

When in the OS - to make the changes permanent.
```
sudo update-grub
sudo grub-install disk
```

### Upgrading to Debian testing breaks APT when trying to downgrade.
Replace "Ubuntu" with "Debian" if you are running Debian
/etc/apt/preferences.d/allow-downgrade
```
Package: *
Pin: release a=stable
Pin-Priority: 1001
```

```
apt-get update
apt-get upgrade
```
Remove the file after and
```
apt-get update
```
If you are missing gnome and the display doesn't work

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install nvidia-driver
sudo shutdown -r now
```

Should be good to go!


### Unbalanced audio with Pulse audio
```
killall pulseaudio; rm -r ~/.config/pulse/* ; rm -r ~/.pulse*
pulseaudio -k 
```

Reboot!

### Create GPG key and export the key format for signing Github commits
```
#Create the key
gpg --gen-key

#Show the key ID
gpg --list-keys

#Set the global Git sign key
git config --global user.signingkey $KEY_ID_HERE

#Set the GPG sign flag to true for all repos.
git config --global commit.gpgsign true

#Export the key with "-----BEGIN PGP PUBLIC KEY BLOCK-----"
gpg --armor --export laurentfdumont@gmail.com > mykey.asc

```

### Using the "ip" tool to change connecticity"
```
ip link set $DEV_NAME down
ip link set $DEV_NAME up

ip route add default via $DEF_GW_IP dev $DEV_NAME
ip addr add $IP_ADDR_CIDR dev $DEV_NAME
ip addr delete $IP_ADDR_CIDR dev $DEV_NAME
```

### Fix BR and VMBR Linux bridges filtering LLDP packets
```
https://interestingtraffic.nl/2017/11/21/an-oddly-specific-post-about-group_fwd_mask/

echo 16384 > /sys/class/net/$VMBR_INTERFACE/bridge/group_fwd_mask
```

### Add fish as the default shell for Ubuntu/Debian.
```
sudo apt-get install fish

coldadmin@big-potato ~> cat /etc/shells 
# /etc/shells: valid login shells
/bin/sh
/bin/bash
/bin/rbash
/bin/dash
/usr/bin/tmux
/usr/bin/fish

chsh -s /usr/bin/fish
```

### One history file for multiple prompts.
```
vim ~/.bashrc
export PROMPT_COMMAND='history -a'
```

### Enable Terminus Powerline on Ubuntu (font name is Terminess)
```
https://github.com/powerline/fonts/issues/210
https://superuser.com/questions/886023/linux-mint-installing-bdf-fonts-with-console-fc-cache-fc-list

git clone https://github.com/powerline/fonts
cd fonts
./install.sh

cd /etc/fonts/conf.d/
sudo rm /etc/fonts/conf.d/10*  
sudo rm -rf 70-no-bitmaps.conf 
sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
sudo dpkg-reconfigure fontconfig
```

### Ubuntu 19.04 - Disable Ubuntu dock completely.

https://askubuntu.com/questions/1030138/how-can-i-get-rid-of-the-dock-in-ubuntu-18
```
cd /usr/share/gnome-shell/extensions/
sudo mv ubuntu-dock@ubuntu.com{,.bak}

```

### Change fan speed of a R710 through IPMI.

IPMI needs to be enabled in ILO!
You need valid credentials!
This disables the auto-adjust of the fan speed, be careful of the R710 heating. I am not responsible for fires :)

```
#Get the ENV data from the IPMI
ipmitool  -I lanplus -H 10.200.10.113 -U root -P $PASSWORD sensor reading "Ambient Temp" "FAN 1 RPM" "FAN 2 RPM" "FAN 3 RPM"

#Enable manual fan control.
ipmitool  -I lanplus -H 10.200.10.113 -U root -P $PASSWORD raw 0x30 0x30 0x01 0x00

#"Activating manual fan speeds! (2160 RPM)"
ipmitool  -I lanplus -H 10.200.10.113 -U root -P $PASSWORD raw 0x30 0x30 0x02 0xff 0x09
```

### Check bonding status

```
cat /proc/net/bonding/mgmt
cat /proc/net/bonding/$INTERFACE_NAME_HERE
```

### Get low-level interface stats

```
ethtool -S $INTERFACE_NAME_HERE
ethtool -S mgmt-1
```

### SSH without using all identity files automatically

```
ssh -o "IdentitiesOnly true" -v -A user@host
```
### Remove resolvctl (issues with OpenVPN DNS being removed)
```bash
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service

dns=default in [main] section of "sudo vi /etc/NetworkManager/NetworkManager.conf"

sudo rm /etc/resolv.conf
sudo service network-manager restart
```

### Troubleshoot APT install errors.
```
# Find the correct file from :
cd /var/lib/dpkg/info/
# In this case, it was the Foreman postinst script
cat foreman.postinst
# Increase verbosity
EXPORT DEBUG=1
# Run the failing configure package
dpkg --configure foreman
```

### Docker Hugo
```
docker run --rm -it -v /srv/hugo:/src -u hugo laurentfdumont/laurent-hugo hugo new site mysite
docker run --rm -it -v /srv/hugo/mysite:/src -u hugo laurentfdumont/laurent-hugo hugo new posts/my-first-post.md
docker run --rm -it -v /srv/hugo/mysite/:/src -u hugo laurentfdumont/laurent-hugo hugo
docker run --rm -it -v /srv/hugo/mysite:/src -p 1313:1313 -u hugo laurentfdumont/laurent-hugo hugo server -b http://linode2.coldnorthadmin.com -w --bind=0.0.0.0
docker run --rm -it -v /srv/hugo/mysite:/src -u hugo laurentfdumont/laurent-hugo hugo new posts/my-first-post.md
docker run --rm -it -v /srv/hugo:/src -u hugo jguyomard/hugo-builder hugo new site mysite 
```

### Check and clean for FSTRIM

Only support for SCSI disk - proxmox.

```
#Check TRIM support status
lsblk -D

### BAD NO support
root@kolla-controller003:~# lsblk -D
NAME              DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
vda                      0        0B       0B         0
|-vda1                   0        0B       0B         0
|-vda2                   0        0B       0B         0
`-vda5                   0        0B       0B         0
  |-system-root          0        0B       0B         0
  `-system-swap_1        0        0B       0B         0

### OK support
root@kolla-compute004:~# lsblk -D
NAME              DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
sda                      0        4K       1G         0
|-sda1                   0        4K       1G         0
|-sda2                1024        4K       1G         0
`-sda5                   0        4K       1G         0
  |-system-root          0        4K       1G         0
  `-system-swap_1        0        4K       1G         0

### Start TRIM PROCESS
fstrim -av
root@kolla-compute004:~# fstrim -av
/boot: 755.4 MiB (792125440 bytes) trimmed
/: 49 GiB (52552167424 bytes) trimmed
```

### Reduce swap size and increase root FS size
```
# Disable swap temporarly.
swapoff -a

# Reduce swap paritition.
lvreduce /dev/superbacon-vg/swap_1 -L -67G

# Extend LVM root paritition.
lvextend /dev/superbacon-vg/root -L +67G

# Extend actual partition size.
resize2fs /dev/superbacon-vg/root

# Recreate swap partition
mkswap /dev/superbacon-vg/swap_1

# Re-enable swap partition
swapon -a
```

### Mount disk to linux
```
# Create an ext4 partition.
mkfs.ext4 /dev/vg-storage/lv-storage

# Mount the partition to test.
mount -t ext4 /dev/vg-storage/lv-storage /mnt

# Mount in /etc/fstab
/dev/mapper/vg--storage-lv--storage /storage    ext4    defaults,nofail        0    1
```

### Check ISCSI disks
```
sudo lsblk -S
```

### Boot logs
```
/var/log/boot.log  ---  System boot log

/var/log/dmesg     ---  print or control the kernel ring buffer
```

### Upgrade Kernel on Centos7
``` 
[root@ooo-director ~]# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
[root@ooo-director ~]# yum install https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm
```

```
[root@ooo-director ~]# yum repolist
Loaded plugins: fastestmirror, priorities
Loading mirror speeds from cached hostfile
 * base: mirror.calgah.com
 * elrepo: iad.mirror.rackspace.com
 * extras: mirror.calgah.com
 * updates: mirror.calgah.com
repo id                                                repo name                                                                                       status
base/7/x86_64                                          CentOS-7 - Base                                                                                  10,097
delorean-train                                         delorean-openstack-trove-7680b5ef0e3608b2c45f057f65337c4af3d5659d                               801+348
delorean-train-build-deps                              dlrn-train-build-deps                                                                            139+78
delorean-train-testing                                 dlrn-train-testing                                                                              875+823
elrepo                                                 ELRepo.org Community Enterprise Linux Repository - el7                                              139
extras/7/x86_64                                        CentOS-7 - Extras                                                                                   307
rdo-qemu-ev/x86_64                                     RDO CentOS-7 - QEMU EV                                                                               87
updates/7/x86_64                                       CentOS-7 - Updates                                                                                1,010
repolist: 13,455
```

```
yum --enablerepo=elrepo-kernel install kernel-ml
```

```
[root@ooo-director ~]# awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
0 : CentOS Linux (5.4.6-1.el7.elrepo.x86_64) 7 (Core)
1 : CentOS Linux (3.10.0-1062.9.1.el7.x86_64) 7 (Core)
2 : CentOS Linux (3.10.0-1062.el7.x86_64) 7 (Core)
3 : CentOS Linux (0-rescue-4fb19b5248cd40d9b9a1ec7361f4f1fa) 7 (Core)

[root@ooo-director ~]# grub2-set-default 0

[root@ooo-director ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-5.4.6-1.el7.elrepo.x86_64
Found initrd image: /boot/initramfs-5.4.6-1.el7.elrepo.x86_64.img
Found linux image: /boot/vmlinuz-3.10.0-1062.9.1.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1062.9.1.el7.x86_64.img
Found linux image: /boot/vmlinuz-3.10.0-1062.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-1062.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-4fb19b5248cd40d9b9a1ec7361f4f1fa
Found initrd image: /boot/initramfs-0-rescue-4fb19b5248cd40d9b9a1ec7361f4f1fa.img
done
```

### PS a process list for process accounting
```
ps -eo cmd 
```

### Send a sysrq though KVM
Types of event
`Dec 26 20:04:49 director kernel: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(V) show-blocked-tasks(w) dump-ftrace-buffer(z)`


```shell
#In the guest VM
echo 1 > /proc/sys/kernel/sysrq

#To make it permanent
[root@director ~]# cat /etc/sysctl.d/sysrq.conf 
kernel.sysrq = 1

#From the Hypervisor
#KEY_B replace what is after the _ for the correct action. This will reboot the target host.
root@kvm01:/tmp# virsh send-key ooo-director KEY_LEFTALT KEY_SYSRQ KEY_B
```

### Install pgcli - postgres cmd line CLI - Ubuntu 19.04
```
sudo apt-get install libpq-dev python-dev
pip3 install pgcli
pgcli --host 127.0.0.1 --port 5432 --user ara_user --dbname ara --password
```

### Redhat / Centos bonding LACP - VLAN
```
modprobe bonding

#vi /etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
Type=Bond
NAME=bond0
BONDING_MASTER=yes
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
BONDING_OPTS="mode=4 miimon=100 lacp_rate=1"

#vi /etc/sysconfig/network-scripts/ifcfg-em1
DEVICE=em1
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
IPV6INIT=no
MASTER=bond0
SLAVE=yes

#vi /etc/sysconfig/network-scripts/ifcfg-em2
DEVICE=em2
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
IPV6INIT=no
MASTER=bond0
SLAVE=yes

#vi /etc/sysconfig/network-scripts/ifcfg-em3
DEVICE=em3
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
IPV6INIT=no
MASTER=bond0
SLAVE=yes
```

### Write speed test
``` https://www.thomas-krenn.com/en/wiki/Linux_I/O_Performance_Tests_using_dd
dd if=/dev/zero of=/root/testfile bs=1G count=1 oflag=dsync
```

### Extend lv
```
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
```

### Set DNS with resolvctl
```
laurentdumont@docker01:/srv$ sudo resolvectl dns 
Global:
Link 17 (vethc025466):
Link 15 (vetheb3b292):
Link 13 (veth45fcbdc):
Link 3 (docker0):
Link 2 (ens192): 10.199.199.1


sudo resolvectl dns ens192 10.199.199.1
```
### Fix openvpn DNS issues with new resolved for DNS
```
sudo apt install openvpn-systemd-resolved
```

### Show disk info
```
lshw -class disk
hwinfo --disk

```
