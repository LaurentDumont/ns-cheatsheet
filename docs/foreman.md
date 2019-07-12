### Foreman

#### Fix failing GEM packages.
```
# As root
su foreman
# cd to home
cd
mv Gemfile.lock Gemfile.lock.backup
/usr/bin/foreman-ruby /usr/bin/bundle update
/usr/bin/foreman-ruby /usr/bin/bundle install
```

#### Remove plugin
```
# Remove the gem file for your plugin.
# rm ~foreman/bundler.d/Gemfile.local.rb
# ~Gemfile.local.rb

# Reinstall all gems without the old one
/usr/bin/foreman-ruby /usr/bin/bundle install

# Restart Foreman
touch ~foreman/tmp/restart.txt
```
