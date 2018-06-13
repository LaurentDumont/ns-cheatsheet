```shell
apt-get update
apt-get install -y postgresql libpq-dev
```

```shell
sudo -u postgres psql
CREATE DATABASE netbox;
CREATE USER netbox WITH PASSWORD 'bigpotato';
GRANT ALL PRIVILEGES ON DATABASE netbox TO netbox;
\q
```

```shell
apt-get install -y python3 python3-dev python3-setuptools build-essential libxml2-dev libxslt1-dev libffi-dev graphviz libpq-dev libssl-dev zlib1g-dev
easy_install3 pip
```

```shell
mkdir -p /opt/netbox/ && cd /opt/netbox/
git clone -b master https://github.com/digitalocean/netbox.git .
pip3 install -r requirements.txt
pip3 install napalm
```

```shell
sudo apt-get install libapache2-mod-wsgi
sudo a2enmod wsgi
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod headers
sudo a2ensite netbox
sudo service apache2 restart
```

```apache
<VirtualHost *:80>
    ServerName netbox.northernsysadmin.com
    Redirect permanent / https://netbox.northernsysadmin.com/
</VirtualHost>

<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile $FULL_CHAIN_CERT_HERE
    SSLCertificateKeyFile $PRIVATE_KEY_CERT_HERE
    ProxyPreserveHost On

    ServerName netbox.northernsysadmin.com

    Alias /static /opt/netbox/netbox/static

    # Needed to allow token-based API authentication
    WSGIPassAuthorization on

    <Directory />
	      SetEnvIfNoCase Host netbox.northernsysadmin\.com VALID_HOST
	      Order Deny,Allow
	      Deny from All
	      Allow from env=VALID_HOST
    </Directory>

    <Directory /opt/netbox/netbox/static>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Require all granted
    </Directory>

    <Location /static>
        ProxyPass !
    </Location>

    RequestHeader set "X-Forwarded-Proto" expr=%{REQUEST_SCHEME}
    ProxyPass / http://127.0.0.1:8001/
    ProxyPassReverse / http://127.0.0.1:8001/
</VirtualHost>

```
