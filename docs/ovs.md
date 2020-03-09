## Openstack OVS concepts
br-int

br-tun

br-ext


### Useful commands
```
ovs-vsctl list interface
ovs-vsctl list port
ovs-vsctl show
ovs-appctl fdb/show mybridge
```

Show all OVS Bridges (OVS Bridges are virtual switches that are linking different ports creating in each switch)
```
ovs-vsctl show
```

List interfaces/ports attached to a bridge
```
ovs-vsctl list-ifaces br-int
```