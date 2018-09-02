####
Clear the splunk index and all data gathered

```
cd /opt/splunk/bin
./splunk stop
./splunk clean eventdata
./splunk start
```
