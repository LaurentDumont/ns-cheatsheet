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
