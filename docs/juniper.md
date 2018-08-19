### Useful commands

```
show configuration

show logging messsage

show | compare

show | display set

show interface terse
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
