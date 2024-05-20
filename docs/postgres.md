### Connect to a database
```
psql -h 192.168.2.40 -U postgres hq_data
```


### Create a database and a user with admin privileges

```
sudo apt-get install postgresql postgresql-client
sudo -u postgres psql
create database netbox;
create user netbox_user with encrypted password 'test';
grant all privileges on database netbox to netbox_user;
```


### Create Read only user
```
CREATE ROLE read_only_user WITH LOGIN PASSWORD 'vKDHrGZuhH6vNf01VdyJ' 
NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';
\connect hq_data;

GRANT CONNECT ON DATABASE hq_data TO read_only_user;
GRANT USAGE ON SCHEMA public TO read_only_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO read_only_user;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO read_only_user;
```

### Show databases
```
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 ara       | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/postgres         +
           |          |          |             |             | postgres=CTc/postgres+
           |          |          |             |             | ara_user=CTc/postgres
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(4 rows)
```

### Show users
```
ara=> \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 ara_user  | Create DB                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```


### Show tables
```
SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';
```

### Describe a table
```
\d TABLE NAME
```

### Drop table
```
drop table hq_electricity_consumption ;
```

### Show active user sessions
```
select pid as process_id, 
       usename as username, 
       datname as database_name, 
       client_addr as client_address, 
       application_name,
       backend_start,
       state,
       state_change
from pg_stat_activity;
```