### Compute node requirements
```
https://docs.openstack.org/nova/rocky/install/compute-install-rdo.html
https://docs.openstack.org/neutron/rocky/install/compute-install-rdo.html
https://docs.openstack.org/neutron/rocky/install/compute-install-option1-rdo.html

```


```
/etc/hosts

10.12.0.2     controller01

10.12.0.3       compute01
10.12.0.4       compute02
10.12.0.5       compute03


################################

10.12.0.3       compute01

10.12.0.2       controller01
10.12.0.4       compute02
10.12.0.5       compute03


################################

10.12.0.4       compute02

10.12.0.2       controller01
10.12.0.3       compute01
10.12.0.5       compute03

################################

10.12.0.5       compute03

10.12.0.2       controller01
10.12.0.3       compute01
10.12.0.4       compute02
```

```
Placeholder password : openstack2019

RABBIT_PASS : openstack2019
rabbitmqctl add_user openstack openstack2019

GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
IDENTIFIED BY 'openstack2019';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
IDENTIFIED BY 'openstack2019';


connection = mysql+pymysql://keystone:openstack2019@controller01/keystone


keystone-manage bootstrap --bootstrap-password openstack2019 \
  --bootstrap-admin-url http://controller01:5000/v3/ \
  --bootstrap-internal-url http://controller01:5000/v3/ \
  --bootstrap-public-url http://controller01:5000/v3/ \
  --bootstrap-region-id RegionOne


export OS_USERNAME=admin
export OS_PASSWORD=openstack2019
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller01:5000/v3
export OS_IDENTITY_API_VERSION=3



openstack domain create --description "Test Domain" example

openstack project create --domain default \
  --description "Service Project" service


GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
  IDENTIFIED BY 'openstack2019';

GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
  IDENTIFIED BY 'openstack2019';


www_authenticate_uri  = http://controller01:5000
auth_url = http://controller01:5000
memcached_servers = controller01:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = openstack2019



### Deploy Compute NOVA service on Controller node.
```
CREATE DATABASE nova_api;
CREATE DATABASE nova;
CREATE DATABASE nova_cell0;
CREATE DATABASE placement;


GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' \
  IDENTIFIED BY 'openstack2019';
GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' \
  IDENTIFIED BY 'openstack2019';

GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
  IDENTIFIED BY 'openstack2019';
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
  IDENTIFIED BY 'openstack2019';

GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost' \
  IDENTIFIED BY 'openstack2019';
GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%' \
  IDENTIFIED BY 'openstack2019';

GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'localhost' \
  IDENTIFIED BY 'openstack2019';
GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'%' \
  IDENTIFIED BY 'openstack2019';


openstack user create --domain default --password-prompt nova

openstack role add --project service --user nova admin


openstack service create --name nova \
  --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne \
  compute public http://controller01:8774/v2.1

openstack endpoint create --region RegionOne \
  compute internal http://controller01:8774/v2.1

openstack endpoint create --region RegionOne \
  compute admin http://controller01:8774/v2.1

openstack endpoint create --region RegionOne \
  placement public http://controller01:8778

openstack endpoint create --region RegionOne \
  placement internal http://controller01:8778


openstack endpoint create --region RegionOne \
  placement admin http://controller01:8778


modprobe br_netfilter
echo "$(sysctl -w net.bridge.bridge-nf-call-iptables=1)" >> /etc/sysctl.conf
echo "$(sysctl -w net.bridge.bridge-nf-call-ip6tables=1)" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf



GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
  IDENTIFIED BY 'openstack2019';

GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
  IDENTIFIED BY 'openstack2019';

openstack endpoint create --region RegionOne \
  network public http://controller01:9696

openstack endpoint create --region RegionOne \
  network internal http://controller01:9696

openstack endpoint create --region RegionOne \
  network admin http://controller01:9696


openstack subnet create --network provider \
  --allocation-pool start=10.13.0.100,end=10.13.0.200 \
  --dns-nameserver 10.13.0.1 --gateway 10.13.0.1 \
  --subnet-range 10.13.0.0/24 provider



openstack server create --flavor m1.nano --image cirros \
  --nic net-id=dee9dde7-0edb-4311-a06e-5ffb98144527 --security-group default \
  provider-instance


nova-manage cell_v2 map_cell0
nova-manage db sync
```