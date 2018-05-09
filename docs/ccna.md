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

### Port-Security

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
#### Mac aging
Dynamic MAC aging default = 0  
absolute timer = Counts down irregardless of traffic  
inactivity timer = resets when traffic is seen from MAC.  
maximum - Default 1
If you raise the number of max MAC addresses on a port, you can run static and dynamic MAC detection.

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

Well-known port number  
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
DORA
Discover - Broadcast from client.
Offer - DHCP server receives Discover and sends unicast offer to client.
Request - Client sends request for the offered IP address.
Ack - DHCP server ack the client request and assigns the IP.