### Connect to a remote server
 - Enable the log of the current status to a file, every 5 seconds

```
sudo openvpn --config s2s-client.ovpn --daemon --status /var/log/openvpn-status 5
```