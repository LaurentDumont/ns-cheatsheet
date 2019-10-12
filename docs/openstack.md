### Random useful commands
```
openstack server list --all -c ID -c Name --host $NOVA_COMPUTE_NAME_HERE -f value
```

### Upload custom image
```
openstack image create --disk-format qcow2 --container-format bare --public --file ./cirros-0.4.0-x86_64-disk.img cirros-0.4.0
```

### Create flavor
```
openstack flavor create --ram 1024 --disk 10 --vcpus 1 --public small-flavor
```

### Create VM
```
openstack server create --image e090519f-91f6-4c21-baf5-08642d0bd28b --flavor f60498da-a9a9-4772-a05c-75b4aaa6389a --network e23f7863-6e84-4395-bbbb-45877e950f2a cumulus-1
openstack server create --image e090519f-91f6-4c21-baf5-08642d0bd28b --flavor f60498da-a9a9-4772-a05c-75b4aaa6389a --network e23f7863-6e84-4395-bbbb-45877e950f2a cumulus-2

```

### Compute node requirements
```
https://docs.openstack.org/nova/rocky/install/compute-install-rdo.html
https://docs.openstack.org/neutron/rocky/install/compute-install-rdo.html
https://docs.openstack.org/neutron/rocky/install/compute-install-option1-rdo.html

```

### Create a external network with a subnet attached to that network.
```
neutron net-create EXT_NET --router:external True --provider:physical_network physnet1 --provider:network_type vlan --provider:segmentation_id 70
neutron subnet-create EXT_NET --name EXT_SUB --allocation-pool start=192.168.70.10,end=192.168.70.100 --disable-dhcp --gateway 192.168.70.1 192.168.70.0/24
```

### Random commands
```
#Create image
openstack image create --disk-format qcow2 --container-format bare --public --file ./cirros-0.4.0-x86_64-disk.img cirros-0.4.0

#Create flavor
openstack flavor create --ram 1024 --disk 10 --vcpus 1 --public small-flavor

#Create network
openstack network create network-floating-ip1
openstack floating ip create --subnet floating-ip-1

#Create provider network with vlan
openstack network create --share --provider-physical-network provider --provider-network-type vlan provider1
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
