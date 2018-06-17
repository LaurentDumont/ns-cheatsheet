### General Troubleshooting
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

<https://www.cisco.com/c/en/us/td/docs/routers/access/4400/troubleshooting/memorytroubleshooting/isr4000_mem.html>
<https://www.cisco.com/c/en/us/support/docs/routers/4000-series-integrated-services-routers/210760-Monitor-CPU-Usage-On-ISR4300-Series.html>
```
show process cpu sorted | ex 0.0
```
```
show platform hardware qfp active datapath utilization
```
```
show platform software status control-processor
```
```
show platform software status control-processor brief
```
```
show processes cpu platform sorted
```
```
show platform software status control-processor brief
```
**Show CPU and Memory like "htop" for Linux**
```
monitor platform software process rp active
```

### Troubleshooting Cisco ISR Memory.

Show IOS processes memory usage.
```
show processes memory
```

Show platform CPU and Memory usage
```
show platform resources
```

Show IOS-XE Memory usage (not IOS)
```
show platform software status control-processor brief
```

### Cisco Radius

```
conf t
aaa new-model

aaa group server radius DHMTL-RADIUS
server-private 10.0.99.22 auth-port 1812 acct-port 1813 key $INSERT_RADIUS_SHARED_SECRET_HERE

aaa authentication login default group DHMTL-RADIUS local
aaa authorization exec default group DHMTL-RADIUS local
```
