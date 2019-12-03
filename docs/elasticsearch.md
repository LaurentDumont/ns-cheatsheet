### Clean indexes old than X days
```
#! /bin/bash
#Script to cleanup the logstash indices.
DELETE_INDICES=$(/usr/bin/curl --silent -XGET 'localhost:9200/_cat/indices' | /bin/egrep -o logstash-20[0-9][0-9]\.[0-9][0-9]\.[0-9][0-9] | /bin/egrep -v "$filter" | /usr/bin/tr '\n' ',')
if [ $DELETE_INDICES ]
then
/usr/bin/curl -XDELETE "localhost:9200/$DELETE_INDICES"
fi
```
