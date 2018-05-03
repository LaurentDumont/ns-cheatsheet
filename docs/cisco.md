
##General Troubleshooting
**IOS-XR**

**!Check Policy-Map drops/number of packet matching the policy.**

```
show policy-map interface $PHYSICAL_INTERFACE service instance $SVC_INST_ID
```

**!Show l2vpn xconnect status (ASR 9k)**

```
show l2vpn service xconnect interface gigabitEthernet 0/1
```

**!Show l2vpn xconnect status with details (ASR 9k)**

```
show l2vpn xconnect neighbor 192.252.143.75 pw-id 702 detail
```

**!Show service-instance traffic details (not xconnect, just local service instance)**

```
show ethernet service instance id 205 int ten0/3/0 detail
```

```
show mpls l2transport vc vcid 395 detail
```


**!ASR 9000 | IOS-XE**

```
show l2vpn service xconnect interface TenGigabitEthernet0/3/0
```

```
show l2vpn xconnect group OPEN01 xc-name OPEN01-C220
```

```
show l2vpn xconnect group PARA07 detail
```

**!BGP stuff | IOS-XE**

```
show bgp summary | inc NEIGHBOR_IP
```
**!BGP stuff | IOS-XR**
```
show ip bgp summary
show ip bgp neighbors
show ip bgp neighbors 1.1.1.1
```

**!Montrer les routes recu d'un neighbor en particulier**
```
conf t
router bgp AS_NUMBER
```
**!Il faut activer le log des routes pour chacun des neighbors BGP concernés**
```
neighbor 1.1.1.1 soft-reconfiguration inbound
exit
sh ip bgp neighbors 1.1.1.1 received-routes
sh ip bgp neighbors 1.1.1.1 advertised-routes
```

```
conf t
router bgp AS_NUMBER
neighbor 1.1.1.1 shutdown
```

**!Satellite 9k light levels**
```
show nV satellite status
telnet vrf **nVSatellite 10.0.100.1
!GigabitEthernet112/0/0/17 ---> Satellite 112
telnet vrf **nVSatellite 10.0.112.1
!Port 17 on ASR = Port 18 on Satellite
sh satellite powerlevels port 30
```
