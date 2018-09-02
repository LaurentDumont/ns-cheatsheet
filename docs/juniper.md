### Useful commands

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

### Syslog

```
set system syslog user * any emergency
set system syslog host 10.0.99.28 any any
set system syslog host 10.0.99.28 port 1514
set system syslog file messages any notice
set system syslog file messages authorization info
set system syslog file interactive-commands interactive-commands any
```

### Radius configuration ###

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
