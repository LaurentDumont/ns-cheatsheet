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
r
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
