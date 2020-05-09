### General troubleshoot - Shamelessly stolen from : http://www.panticz.de/index.php/openstack
```bash
# list VMs on all hypervisor
openstack server list --all --long  -c Name -c Host
 
# list VMs on specific hypervisor
openstack server list --all -c Name -f value --host ${COMPUTE_NODE}
 
# get VM count by hypervisor
openstack server list --all --long  -c Host -f value | sort | uniq -c
 
# list compute nodes
openstack compute service list
 
# list compute service
openstack compute service list --host ${OS_NODE}
 
# disable compute service
for OS_SERVICE in $(openstack compute service list --host ${OS_NODE} -c Binary -f value); do
    openstack compute service set --disable --disable-reason "Maintenance" ${OS_NODE} ${OS_SERVICE}
done
 
openstack compute service set --disable --disable-reason potato qasite1-compute001.localdomain nova-compute

# Search for server witch status error
openstack server list --all --status ERROR
 
# Search for server with status resizing
openstack server list --all --status=VERIFY_RESIZE
 
# List instances / VMs
openstack server list
openstack server list -c ID -c Name -c Status -c Networks -c Host --long
```

### Start all VMs on a single compute
```
for x in `openstack server list --all -c ID -f value --host tenlab1-compute002.localdomain`;do openstack server start $x;done 
```

### Migrate to specific compute
```
nova host-evacuate --target_host kolla-compute003 kolla-compute004.cmaker.studio
watch nova migration-list
```

### Get all the keypairs existing for all users
```
for x in `openstack user list -f value -c ID`;do echo $x && nova keypair-list --user $x;done
```

### Evacuate single server from compute
```
nova evacuate 1d6a436b-e18e-45ce-8b01-bee4a7126f81
```

### Evacuate single server from compute to a specific destination
```
nova evacuate 5f58a1bf-a7f9-4952-b980-af9d52a11e66 qasite1-compute001.localdomain
```

### Openstack create image with different id.
Use the `--id` flag
```
openstack image create --id cirros-0.4.0 --disk-format qcow2 --container-format bare --public --file ./cirros-0.4.0-x86_64-disk.img cirros-0.4.0
```

```bash
07d76f4e-c920-49ea-af06-bd3c322f16cf

openstack router set --external-gateway EXT_NET --enable-snat --fixed-ip subnet=EXT_SUB,ip-address=192.168.70.2

neutron net-create PROV_NET --shared --router:external True --provider:physical_network physnet1 --provider:network_type vlan --provider:segmentation_id 71
neutron subnet-create PROV_NET --name PROV_SUB --disable-dhcp --gateway 192.168.71.1 192.168.71.0/24

neutron net-create EXT_NET --router:external True --provider:physical_network physnet1 --provider:network_type vlan --provider:segmentation_id 70
neutron subnet-create EXT_NET --name EXT_SUB --allocation-pool start=192.168.70.10,end=192.168.70.100 --disable-dhcp --gateway 192.168.70.1 192.168.70.0/24

network : e23f7863-6e84-4395-bbbb-45877e950f2a
subnet : 5bee0941-8d7f-4869-896d-e34e1f2e8b3d

9ce38b2c-b13b-4e65-8e68-32b146115a62 : openstack port create --fixed-ip subnet=5bee0941-8d7f-4869-896d-e34e1f2e8b3d,ip-address=10.100.100.10 --network e23f7863-6e84-4395-bbbb-45877e950f2a cumulus_1

eefa2140-fd69-4daf-8b0d-0eafcf3e24b9 : openstack port create --fixed-ip subnet=5bee0941-8d7f-4869-896d-e34e1f2e8b3d,ip-address=10.100.100.11 --network e23f7863-6e84-4395-bbbb-45877e950f2a cumulus_2

neutron net-create PROV_NET --router:external True --provider:physical_network physnet1 --provider:network_type vlan --provider:segmentation_id 71
neutron subnet-create PROV_NET --name PROV_SUB --allocation-pool start=192.168.71.10,end=192.168.71.100 --disable-dhcp --gateway 192.168.71.1 192.168.71.0/24
neutron net-create PROV_NET --shared --router:external True --provider:physical_network physnet1 --provider:network_type vlan --provider:segmentation_id 71
neutron subnet-create PROV_NET --name PROV_SUB --disable-dhcp --gateway 192.168.71.1 192.168.71.0/24
```

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

openstack flavor create --ram 16384 --disk 21 --vcpus 8 \
--private \
--project $PROJECT_ID_HERE \
--property aggregate_instance_extra_specs:$HOST_AGG_NAME_HERE='true' \
--property hw:cpu_policy='dedicated' \
--property hw:cpu_thread_policy='prefer' \
--property hw:mem_page_size='1GB' \
--property hw:numa_cpus.0='1-7' \
--property hw:numa_cpus.1='0' \
--property hw:numa_mem.0='8192' \
--property hw:numa_mem.1='8192' \
--property hw:numa_mempolicy='strict' \
--property hw:numa_nodes='2' \
TEST
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
