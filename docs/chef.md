### Chef server setup
```
sudo dpkg -i /tmp/chef-server-core-<version>.deb
chef-server-ctl reconfigure
chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME
chef-server-ctl org-create northernsysadmin 'Northern Sysadmin Inc' --association_user sysadmin --filename /var/chef_ssh/northernsysadmin-validator.pem
```

```
knife ssl check
knife ssl fetch

knife cookbook upload $COOKBOOK_NAME_HERE
knife client list
knife cookbook list
```

```
knife bootstrap 10.255.255.8 --ssh-user sysadmin --ssh-password 'PASSWORD_HERE' --sudo --use-sudo-password --node-name puppet-minion1 --run-list 'recipe[learn_chef_apache2]'
```

```
knife node list
knife node show $NODE_NAME
```

### Create roles and assign cookbooks to them.
roles/ntp.json
```json
{
   "name": "ntp",
   "description": "NTP server role.",
   "json_class": "Chef::Role",
   "default_attributes": {
     "chef_client": {
       "interval": 60,
       "splay": 1
     }
   },
   "override_attributes": {
   },
   "chef_type": "role",
   "run_list": ["recipe[chef-client::default]",
                "recipe[chef-client::delete_validation]",
                "recipe[ntpd::default]"
   ],
   "env_run_lists": {
   }
}
```

1. Upload the role to the Chef Server : `knife role from file roles/web.json`
2. Check that the role is on the server : `knife role list` - `knife role show ntp`
3. Find node name from `knife node list` - `knife node run_list set puppet-minion1 "role[ntp]"`
4. Confirm that the role is applied to the Node : `knife node show puppet-minion1 --run-list`
5. Run `chef-client` on the node.
6. `knife ssh 10.255.255.8 'role:web' 'sudo chef-client' --ssh-user sysadmin --ssh-password 'PASSWORD_HERE' --sudo --use-sudo-password --node-name puppet-minion1`
