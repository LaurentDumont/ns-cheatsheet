### Create a database and a user with admin privileges

```
sudo apt-get install postgresql postgresql-client
sudo -u postgres psql
create database netbox;
create user netbox_user with encrypted password 'test';
grant all privileges on database netbox to netbox_user;
```