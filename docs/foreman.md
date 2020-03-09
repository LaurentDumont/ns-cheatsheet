### Remove old kernel boot files (sometimes necessary when the deployment fails with a Kernel not found/mismatch error)
```bash
ldumont@foreman:/srv/tftp/boot$ ls -alh
total 189M
drwxr-xr-x 2 foreman-proxy root          4.0K Mar  9 12:53 .
drwxr-xr-x 8 root          nogroup       4.0K Dec 16  2018 ..
-rw-r--r-- 1 foreman-proxy foreman-proxy  53M Sep  6  2019 centos-mirror-qVbSBrznIWMc-initrd.img
-rw-r--r-- 1 foreman-proxy foreman-proxy 6.5M Aug  7  2019 centos-mirror-qVbSBrznIWMc-vmlinuz
-rw-r--r-- 1 foreman-proxy foreman-proxy  30M Feb  1 09:55 debian-mirror-wXTzvPQ8AfC3-initrd.gz
-rw-r--r-- 1 foreman-proxy foreman-proxy 5.1M Feb  1 09:55 debian-mirror-wXTzvPQ8AfC3-linux
-rw-r--r-- 1 foreman-proxy foreman-proxy  36M Apr 20  2016 ubuntu-16.04-16.04.5-x86_64-initrd.gz
-rw-r--r-- 1 foreman-proxy foreman-proxy 6.7M Apr 20  2016 ubuntu-16.04-16.04.5-x86_64-linux
-rw-r--r-- 1 foreman-proxy foreman-proxy  45M Apr 25  2018 ubuntu-mirror-WKCIULkETfqj-initrd.gz
-rw-r--r-- 1 foreman-proxy foreman-proxy 7.9M Apr 25  2018 ubuntu-mirror-WKCIULkETfqj-linux

# Remove the all files related to a single OS.
sudo rm -f debian-mirror*
```

### Update Foreman
```
#https://theforeman.org/manuals/1.22/index.html#3.6Upgrade

systemctl apache2 stop
# Upgrade .list file from /etc/apt/sources.list.d/foreman.list
apt-get update
apt-get --only-upgrade install ruby\* foreman\*
foreman-rake db:migrate
foreman-rake db:seed
foreman-rake tmp:cache:clear
foreman-rake db:sessions:clear

# Test Foreman upgrade
foreman-installer --noop --dont-save-answers --verbose
# Start Foreman installer upgrade.
foreman-installer
service apache2 restart
```


#### Fix failing GEM packages.
```bash
# As root
su foreman
# cd to home
cd
mv Gemfile.lock Gemfile.lock.backup
/usr/bin/foreman-ruby /usr/bin/bundle update
/usr/bin/foreman-ruby /usr/bin/bundle install
```

#### Remove plugin
```bash
# Remove the gem file for your plugin.
# rm ~foreman/bundler.d/Gemfile.local.rb
# ~Gemfile.local.rb

# Reinstall all gems without the old one
/usr/bin/foreman-ruby /usr/bin/bundle install

# Restart Foreman
touch ~foreman/tmp/restart.txt
```
