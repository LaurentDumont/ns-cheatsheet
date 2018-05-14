## Cisco Security

### User and access management

Enable secret takes precedence over enable password.
```
enable password potato
enable secret potato2

enable password = potato2
```

Create user with default privilege 15 level
```
conf t
username $USERNAME privilege 15 secret $PASSWORD
```

login = password and username of the vty itself.
login local = Local username database
```
conf t
line con 0
login local
exec-timeout 0 0
logging synchronous
```

Line VTY user are set to privilege 15 automatically.
```
conf t
line vty 0 15
privilege level 15
```

```
service password-encryption
```

### Port-Security ###

Enabling port security on port
Cannot be enabled on a trunk/dynamic/auto port. Must be an access port.
```
conf t
interface gigabitethernet0/1
switchport port-security
```

Keep MAC addresses when port-shutdown or switch reload.
```
conf t
interface gigabitethernet0/1
switchport port-security
switchport port-security mac-address sticky
```
### MAC aging ###
Dynamic MAC aging default = 0  
absolute timer = Counts down irregardless of traffic  
inactivity timer = resets when traffic is seen from MAC.  
maximum - Default 1
If you raise the number of max MAC addresses on a port, you can run static and dynamic MAC detection.

#### MAC address conversion ####

| Character  | HEX  |
|-------------|-----|
| a | 10 |
| b | 11 |
| c | 12 |
| d | 13 |
| e | 14 |
| f | 15 |

* One digit hex ---> 0-9 or A-F
* Two digit hex ---> Left to Right, units of 16 ---> units of 1.

Hexadecimal A7 to decimal
A = 10 units of 16 (A=16) ---> 160  
7 = 7 units of 1 ---> 7  
160 + 7 = 167

Decimal 241 to Hexadecimal
1. f = 15 * 16
2. 1 = 1 * 1
3. F1



#### Violation option  
**protect** - Drops traffic, no SYSLOG, no SNMP Trap, no counters increased    
**restrict** - Drops traffic, generate SNMP trap, generate SYSLOG.  
**shutdown** - Default, increase violation counters, Port shutdown in error-disabled.  


Show port-security commands
```
show port-security interface fastethernet 0/1
```

```
show port-security address
```

Error disabled recovery  
Default recovery 300 seconds
```
conf t
errordisable recovery cause ?
errordisable recovery cause psecure-violation
errdisable recovery interval 30
```

```
show errdisable recovery
```

### VLAN interfaces (SVI)
* Layer 2 vlan must exist
* Physical interface with vlan attached to must be in UP and UP.
  * Can be a trunk with vlan allowed or an access port with the vlan.

### Autonegociation - Speed and Duplex ###
* Highest speed supported by both is used.
* Full duplex supported by both is used.
* **DO NOT** set one side auto and the other side forced.
* Symptoms --> Slow Upload, irregular speed, packet loss, CRC/Runt frames errors on the interface

### Interface range ###
```
interface range fastethernet 0/1-24
interface range fastethernet 0/1-24,25,26
```

### TCP and UDP ###

#### TCP ####
* Guarantees delivery of segments
* Error Detection and recovery
  * Sequence numbers and ACK to recover from lost/corrupt packets
* TCP Windowing
* Connection-oriented
  * Three-way handshake
  * SYN FLAG / ACK FLAG
  * Source ---> Destination : SYN
  * Destination ---> Source : SYN-ACK
  * Source ---> Destination : ACK
  * Connection Established
* When connection is terminated - 4 Way Handshake
  * Client ---> Server : FIN, ACK
  * Client <--- Server : ACK
  * Client <--- Server : ACK, FIN
  * Client ---> Server : ACK
* Flow control and Windowing
  * The receiver increases the Window size / controls the flow.
  * The receiver asks for more data when traffic flows well --> No errors/retransmits on packets.

![TCP-3WAY](/images/tcp-3way-handshake.gif)

### UDP ###
* "Best Effort"
* No Error Detection
* No Windowing
* Connectionless - Data is sent without the remote peer being aware.

#### Port Numbers ####

Well-known port numbers:  

| Protocol / Transport  | Port  |
|-------------|-----|
| HTTPS / TCP | 443 |
| SNMP / UDP  | 161 |
| SMTP / TCP  | 25 |
| TELNET / TCP  | 22 |
| SSH / TCP  | 23 |

Socket ---> Combination of an ipaddress and a port number.  
192.168.1.1:10000

### DHCP ###
**DORA**
1. Discover - Broadcast from client.  
2. Offer - DHCP server receives Discover and sends unicast offer to client.  
3. Request - Client sends request for the offered IP address.  
4. Ack - DHCP server ack the client request and assigns the IP.  

### Routing - Static Routes ###

```
ip route destination_subnet destination_mask [local-router-exit-interface | next-hop-ip-address]

ip route 2.2.2.2 255.255.255.0 192.168.1.1

#Default Route
ip route 0.0.0.0 0.0.0.0 [local-router-exit-interface | next-hop-ip-address]

```

### Routing - Distance Vector Protocols - RIP ###

**RIPv1 / IGRP**

* Full route table update at fixed interval. Every 30 seconds for RIP.
* Do not subnet VLSM.
* No Packet authentication.

**RIPv2**

* Supports VLSM.
* Multicasts from router updates - 224.0.0.9 instead of broadcast (RIPv1)
* Supports Authentication.
* Supports route summarization.

**Split Horizon**

* A route cannot be advertised via an interface that received the route in the first place.
* No split horizon on frame-relay.

**Route Poisoning**

* When all routers have the same routing table --> State of convergence  
* Slow to converge
* When router removes a subnet that is local to itself.
  * Send update that shows 16 hops for the removed subnet.
  * Other routers will receive the update and remove the route from their own routing tables as 16 hops marks a subnet as unreachable.

**Hops**

* Metric for RIPv2.
* Measures of distance to reach a specific subnet.
* Does not care about interface speed - only hop count.

#### Enabling RIPv2 ####
```
conf t
router rip

#Show protocols active on router
show ip protocols

#Enable specific version of RIPv2 per interface or global.
interface gig0/1
ip rip send version 2

conf t
router rip
rip version 2
network 10.10.10.0
network 10.10.11.0

#Disable auto summary
conf t
router rip
no auto-summary

#Enable split Horizon
interface serial0/1/0
ip split-horizon
```

Confirming that RIPV2 works.
```
show ip protocols
show ip rip database
```

Clear RIP routes.
```
clear ip route *
```

#### Passive interfaces ####
Prevents sending RIPv2 updates from interfaces where it's not necessary.

```
conf t
router rip
passive-interface fastethernet0/1
passive-interface fastethernet0/2
```

```
conf t
router rip
passive-interface default
no passive-interface fastethernet0/1
no passive-interface fastethernet0/2
```

#### RIP Load Balancing ####
1) If a subnet is reachable through two paths with the same hope count --> Load balance across the two links.

Disabling equal cost load balancing
```
conf t
router rip
maximum-path 1
```

#### Default route in RIP ####

```
conf t
router rip
default-information originate
```

### Routing Administrative distance ###

1) The prefix mask is considered first. The more specific route is installed.  
2) If the prefix max is "=" ---> Administrative Distance is checked. The route with the lowest ADs wins.  

![ROUTING-AD](/images/admin-routing-dist.png)

### Floating static routes ###

If a route with a lower AD is removed from the routing table, the static route will be added and become active.

```
conf t
ip route 2.2.2.0 255.255.255.0 21.1.1.2 [static route metric here | higher than routing protocol 1-255 ]
```

### Subnetting ###
