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

### Install the Train repository
```bash
sudo -E tripleo-repos -b rocky current
```

### Get the TripleO CLI client (lots of stuff to install)
```bash
sudo yum install -y python-tripleoclient
```
