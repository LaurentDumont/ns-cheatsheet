### Radius configuration ###

```
edit
set system radius-server $RADIUS_SERVER_IP_HERE source-address $SWITCH_IP_HERE
set system radius-server $RADIUS_SERVER_IP_HERE secret $PASSWORD_HERE

set system authentication-order [ password radius ]

set system login user remote class super-user
```
