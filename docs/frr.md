### Enter FRR shell
```
sudo vtyshell
```

### Show bgp neigbors
```
show bgp neighbors
show bgp summary
```

### Show information from neighbors
```
show bgp vrf all ipv4 neighbors x.x.x.x advertised-routes
show bgp vrf all ipv4 neighbors x.x.x.x received-routes 
```

### FRR pfsense
```
show bgp ipv4 unicast neighbors 170.39.196.221 advertised-routes
show bgp summary
```