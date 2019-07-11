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
