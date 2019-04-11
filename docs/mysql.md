### Create Database and user.

```
CREATE DATABASE `racktables`;
CREATE USER 'racktables_user' IDENTIFIED BY 'test';
GRANT ALL privileges ON `racktables`.* TO 'racktables_user'@'%';


CREATE DATABASE `netbox`;
CREATE USER 'netbox_user' IDENTIFIED BY 'test';
GRANT ALL privileges ON `netbox`.* TO 'netbox_user'@'%';
```