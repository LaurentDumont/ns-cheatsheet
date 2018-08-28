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

## When Windows 10 Creator upgrade breaks Linux Grub
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

## Upgrading to Debian testing breaks APT when trying to downgrade.
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
