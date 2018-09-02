####
Clear the splunk index and all data gathered. Will delete most of the existing data!

```
cd /opt/splunk/bin
./splunk stop
./splunk clean eventdata
./splunk start
```
