**Check which devices are impacted**
```
sort var/logs/VPN.20180109.070410  | grep -i key | uniq
```

**Only show the device name to pipe into ssh-keygen**
```
sort var/logs/VPN.20180109.070410  | grep -i key | uniq | grep -Eo '^[^ ]+'
```
```
sort /opt/rancid/var/logs/VPN.20180111.064300  | grep -i key | uniq | grep -Eo '^[^ ]+'
```

**Remove the public keys**
```
ssh-keygen -f "/opt/rancid/.ssh/known_hosts" -R ###REMOTE_IP_OF_DEVICE###
```

**Check the master zones (not ARPA or random files ) we are hosting**
```
ls -alh --ignore=*.arpa* | wc -
```
