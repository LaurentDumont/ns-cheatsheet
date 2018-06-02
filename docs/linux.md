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
