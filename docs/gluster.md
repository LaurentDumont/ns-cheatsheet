```
sudo gluster peer probe kube2
```

```
sudo gluster peer status
```

```
sudo gluster volume create gluster-vol-1 replica 2 transport tcp kube1:/gluster/gluster-vol-1 kube2:/gluster/gluster-vol-1
```

### No replicate - single server.
```
gluster volume create $VOLUME_NAME $IPADDRESS_OR_DOMAINNAME:/$ROOT_MOUNT_POINT/$SUBFOLDER
gluster volume start $VOLUME_NAME
```

### Mount a gluster share.
```
mount -t glusterfs $GLUSTER_SERVER_IP:$SHARE_NAME $LOCAL_PATH
```

```
sudo gluster volume start gluster-vol-1
```
