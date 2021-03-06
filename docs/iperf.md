**UDP TEST (DDOS like test where you send traffic to the other endpoint without any policing.**  
iPerf3 does not allow you to send traffic directly for UDP. It needs to "connect" to an iPerf3 endpoint, even for UDP.

```
./iperf -c TARGET_IP --udp --interval 2 --bandwidth 9m
```
**IPERF SERVER TCP**
```
./iperf --server
```
**IPERF CLIENT TCP UPLOAD AND THEN DOWNLOAD**
```
./iperf --client IPERF_SERVER --tradeoff --window 1M
```
**IPERF CLIENT TCP UPLOAD AND DOWNLOAD AT THE SAME TIME**
```
./iperf --client IPERF_SERVER --dualtest --window 1M
```

## Iperf Systemd file
```
[ec2-user@perf-server ~]$ sudo cat /etc/systemd/system/iperf3.service 
# /etc/systemd/system/iperf.service
[Unit]
Description=iperf server
After=syslog.target network.target auditd.service

[Service]
ExecStart=/usr/bin/iperf3 --log /var/log/iperf/iperf-server.log --server

[Install]
WantedBy=multi-user.target
```