### Useful commands.

```
show configuration

show logging messsage

show | compare

show | display set

show interface terse

show chassis hardware

show route

show interface | incl (proto|Desc)

show system process
```

### Syslog configuration.

```
set system syslog user * any emergency
set system syslog host 10.0.99.28 any any
set system syslog host 10.0.99.28 port 1514
set system syslog file messages any notice
set system syslog file messages authorization info
set system syslog file interactive-commands interactive-commands any
```

### Radius configuration.

```
edit
set system radius-server $RADIUS_SERVER_IP_HERE source-address $SWITCH_IP_HERE
set system radius-server $RADIUS_SERVER_IP_HERE secret $PASSWORD_HERE

set system authentication-order [ radius password ]

#Create user profiles based on FreeIPA group.

edit system login
set user HELPDESK class read-only
set user OPERATOR class super-user
set user remote full-name "default remote access user template"
set user remote class read-only
```

### Create a L3 VLAN interface.
```
set vlans MGMT vlan-id 69
set interfaces ge-0/0/23 unit 0 family ethernet-switching port-mode trunk 666 vlan members 69
set interfaces vlan unit 69 family inet address 10.10.69.14/24
set vlans MGMT l3-interface vlan.69
```

### Enable SSH with root login.
```
set system services ssh root-login allow
```

### Create a default route.
```
set routing-options static route 0.0.0.0/0 next-hop 10.10.69.1
```

### Add a nameserver for DNS resolution.
```
edit system name-server 8.8.8.8 
```

### Upgrade the JunOS image.
```
request system software add http://web.weba.ru/pub/500G_3/Firmware/Juniper/12.3/domestic/jinstall-ex-2200-12.3R5.7-domestic-signed.tgz

file copy http://web.weba.ru/pub/500G_3/Firmware/Juniper/12.3/domestic/jinstall-ex-2200-12.3R5.7-domestic-signed.tgz  /var/tmp/

request system software add /var/tmp/jinstall-ex-2200-12.3R5.7-domestic-signed.tgz reboot
```

### Repair a JunOS partition that rebooted from the backup partition.
```
***********************************************************************
**                                                                   **
**  WARNING: THIS DEVICE HAS BOOTED FROM THE BACKUP JUNOS IMAGE      **
**                                                                   **
**  It is possible that the primary copy of JUNOS failed to boot up  **
**  properly, and so this device has booted from the backup copy.    **
**                                                                   **
**  Please re-install JUNOS to recover the primary copy in case      **
**  it has been corrupted and if auto-snapshot feature is not        **
**  enabled.                                                         **
**                                                                   **
***********************************************************************

```

```
show chassis alarms
show system storage partitions
request system snapshot media internal slice alternate
show system snapshot media internal
request system reboot slice alternate media internal
```

### Create an admin user.
```
set system login user cmaker authentication plain-text-password
set system login user cmaker class super-user
```

### Add a SSH key to a local user for password-less auth.
```
set system login user prox-exporter-juniper authentication ssh-rsa "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJZTRPs8WXsD1yNmWd69/zHNDf4ApvTXDjfk0rxEjgiDsOgWvID0Q8ZH0tFzSV9L0W7a/9jG0POuJyiGYF6M4X2QdEPSZ2CgxRm7GL4A1SJ4xbnCYny2k4L8C7UrDrvqThv6/FyyJopHCPp7S3j0iAI6c+Gtv59sbUvdilWC4Y5LX0ho+yocMaGvTOk+l5aQRU9eWmZsD0/3D0V99iBnm70rlEeEIr1Oe+M+y/Q/0vmBVdC75COCxu84PnLvqPH2yOf3j581wgIVncKbApB0b9ApTbCE94jNljtwM4uGM9qICOf0BwbrDfFT1L1n5ZQx7BZnD9410wv2jTYXTPUJV1"
set system login user prox-exporter-juniper class super-user
```

### Password recovery
```
Boot normally.

Prompt : Hit [Enter] to boot immediately, or space bar for command prompt.

press space during the boot process

Type :
loader> boot -s

Type : 
Enter full pathname of shell or 'recovery' for root password recovery or RETURN for /bin/sh: recovery
```

### Configure SNMP with contact and location strings.
```
set snmp name “cmaker-ex2200” description “cmaker-ex2200”
set snmp location “9880 Clark”
set snmp contact "laurentfdumont@gmail.com"
set snmp community cmaker authorization read-only
```