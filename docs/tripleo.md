### Update all the system packages first
```
yum update
```

- Make sure hostname of the director resolves to 127.0.0.1
- Make sure hostname is a FQDN.


### Undercloud deployment
```bash
sudo useradd stack
sudo passwd stack  # specify a password

echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
sudo chmod 0440 /etc/sudoers.d/stack

su - stack
```

### Get the packages for Centos
```bash
sudo yum install -y https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-0.0.1-0.20191108012952.2655019.el7.noarch.rpm
```

### Install the Rocky repository
```bash
sudo -E tripleo-repos -b stein current
```

### Get the TripleO CLI client (lots of stuff to install)
```bash
sudo yum install -y python-tripleoclient
``` 

### Copy the default deployment template
```
cp /usr/share/python-tripleoclient/undercloud.conf.sample ~/undercloud.conf
```

### Deploy the Undercloud
```
openstack undercloud install
```

### Overcloud Deployment
```
export DIB_YUM_REPO_CONF="/etc/yum.repos.d/delorean*"

#Build the images for the Overcloud
openstack overcloud image build

# Upload the images
openstack overcloud image upload
```

### Add DNS to Overcloud
```
(undercloud) [stack@director ~]$ openstack subnet list
+--------------------------------------+-----------------+--------------------------------------+-----------------+
| ID                                   | Name            | Network                              | Subnet          |
+--------------------------------------+-----------------+--------------------------------------+-----------------+
| 08a306ed-a5e8-47cd-ac66-a67722d03a42 | ctlplane-subnet | fcda1208-3d2c-4b9c-a241-c4bcd0479b9f | 192.168.24.0/24 |
+--------------------------------------+-----------------+--------------------------------------+-----------------+

openstack subnet set 08a306ed-a5e8-47cd-ac66-a67722d03a42 --dns-nameserver 8.8.8.8
```

### Register the nodes
The `instackenv.json` file.
```json
{
    "nodes": [
        {
            "mac":[
                "52:54:00:25:ca:d3"
            ],
            "name": "ooo-controller001",
            "pm_type": "ipmi",
            "cpu": "4",
            "memory": "9216",
            "disk": "50",
            "arch": "x86_64",
            "pm_user": "test",
            "pm_password": "secret",
            "pm_addr": "10.10.99.62",
            "pm_port": "16001"
        },
        {
            "mac":[
                "52:54:00:1a:cc:2a"
            ], 
            "name": "ooo-controller002",
            "pm_type": "ipmi",
            "cpu": "4",
            "memory": "9216",
            "disk": "50",
            "arch": "x86_64",
            "pm_user": "test",
            "pm_password": "secret",
            "pm_addr": "10.10.99.62",
            "pm_port": "16002"
        },
        {
            "mac":[
                "52:54:00:1c:0c:94"
            ],
            "name": "ooo-controller003",
            "pm_type": "ipmi",
            "cpu": "4",
            "memory": "9216",
            "disk": "50",
            "arch": "x86_64",
            "pm_user": "test",
            "pm_password": "secret",
            "pm_addr": "10.10.99.62",
            "pm_port": "16003"
        }
    ]
}
```
### Create the nodes within Ironic Openstack
```
openstack overcloud node import instackenv.json
```

### Ironic paths
```shell
#DNSMASQ
/var/lib/ironic-inspector/dhcp-hostsdir
#Ironic PXE
/var/lib/ironic/httpboot/
```

### List nodes
```
openstack baremetal node list
``` 

### Start introspection
```
openstack overcloud node introspect --all-manageable

# One node
openstack overcloud node introspect 32124951-3fcc-4da4-ba16-d05a3c66bb22
``` 

### If introspection works, make nodes available
```
openstack overcloud node provide --all-manageable
```

### Deploy Overcloud
```
openstack overcloud deploy --templates
```

### Get extra-hardware-specs from Ironic.
```
openstack baremetal introspection data save 32124951-3fcc-4da4-ba16-d05a3c66bb22
```

### Delete deployed Overcloud
```shell
(undercloud) [stack@ooo-director ~]$ openstack stack list
+--------------------------------------+------------+----------------------------------+--------------------+----------------------+--------------+
| ID                                   | Stack Name | Project                          | Stack Status       | Creation Time        | Updated Time |
+--------------------------------------+------------+----------------------------------+--------------------+----------------------+--------------+
| a078f570-c4fa-46bc-87d5-ebb2c99684e4 | overcloud  | 8a6fa7c4e66a422281bd800007c65e4d | CREATE_IN_PROGRESS | 2019-12-26T04:00:21Z | None         |
+--------------------------------------+------------+----------------------------------+--------------------+----------------------+--------------+

#Might need to do 2-3 times... (not sure why)
(undercloud) [stack@ooo-director ~]$ openstack stack delete a078f570-c4fa-46bc-87d5-ebb2c99684e4
Are you sure you want to delete this stack(s) [y/N]? y


openstack overcloud plan delete overcloud
```

### List Overcloud nodes profiles
```
openstack overcloud profiles list
```

### Set compute/controller profile
```
openstack baremetal node set --property capabilities='profile:compute,boot_option:local' 
```

