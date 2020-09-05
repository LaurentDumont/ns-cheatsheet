### Random commands
```
net add interface swp1 ip address 170.39.196.82/32
net add bgp autonomous-system 65000
net add bgp neighbor 170.39.196.81 remote-as 65000
net add bgp neighbor 170.39.196.81 password PASSWORD
net add bgp ipv4 unicast neighbor 170.39.196.81 next-hop-self
net add bgp redistribute connected


net add bgp neighbor 170.39.196.85 remote-as 65000
net add bgp neighbor 170.39.196.85 password PASSWORD
net add bgp ipv4 unicast neighbor 170.39.196.81 next-hop-self
net add bgp redistribute connected

net add bgp neighbor 170.39.196.84 remote-as 65000
net add bgp neighbor 170.39.196.84 password PASSWORD
net add bgp ipv4 unicast neighbor 170.39.196.81 next-hop-self
net add bgp redistribute connected


net add bgp neighbor 170.39.196.89 remote-as 65000
net add bgp neighbor 170.39.196.89 password PASSWORD
net add bgp ipv4 unicast neighbor 170.39.196.89 next-hop-self
net add bgp redistribute connected


net add bgp ipv4 unicast neighbor 170.39.196.84 next-hop-self
net add bgp ipv4 unicast neighbor 170.39.196.87 next-hop-self
  

net add ospf network 170.39.196.80/28 area 0
net add ospf default-information originate
net add ospf redistribute connected
net commit

```
