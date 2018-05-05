## Cisco Security

### User and access management

Create user with default privilege 15 level
```
conf t
username $USERNAME privilege 15 secret $PASSWORD
```

Login local = Local username database

```
conf t
line con 0
login local
exec-timeout 0 0
logging synchronous
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
