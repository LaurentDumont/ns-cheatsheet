### Discover login targets
```
iscsiadm --mode discoverydb -t sendtargets --portal $ISCSI_SERVER_IP --discover -d 7
```

### Show iscsi stats
```
sudo iscsiadm --mode session --stats
```