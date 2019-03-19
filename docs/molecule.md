## Testing framework for Ansible.
### Installation Ubuntu 18.04 LTS


```
sudo apt-get install -y python-pip libssl-dev
pip install --user molecule
```

### Create a test setup in an existing role
```
#From within the role folder
molecule init scenario -r my-role-name
```

### Start a full testing run
```
sudo molecule test
```