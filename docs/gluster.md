```
sudo gluster peer probe kube2
```

```
sudo gluster peer status
```

```
sudo gluster volume create gluster-vol-1 replica 2 transport tcp kube1:/gluster/gluster-vol-1 kube2:/gluster/gluster-vol-1
```

```
sudo gluster volume start gluster-vol-1
```
