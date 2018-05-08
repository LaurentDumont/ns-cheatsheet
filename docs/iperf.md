**UDP TEST (DDOS like test where you send traffic to the other endpoint without any policing.**  
iPerf3 does not allow you to send traffic directly for UDP. It needs to "connect" to an iPerf3 endpoint, even for UDP.

```
./iperf -c TARGET_IP -u -i 2 -b 9m -t 600
```
**IPERF SERVER TCP**
```
./iperf -s -i 2
```
**IPERF CLIENT TCP UPLOAD AND THEN DOWNLOAD**
```
./iperf -c IPERF_SERVER -i 2 -t 100 -p 5001 -P5 -w 1M -r
```
**IPERF CLIENT TCP UPLOAD AND DOWNLOAD AT THE SAME TIME**
```
./iperf -c IPERF_SERVER -i 2 -t 100 -p 5001 -P5 -w 1M -r
```
