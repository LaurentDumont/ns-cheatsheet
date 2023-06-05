https://wiki.ubuntu.com/DebuggingBluetooth#:~:text=On%20desktop%3A,%2Fvar%2Flog%2Fsyslog

## Basic bluetooth troubleshooting commands
```
bluetoothctl --version
```
```
hciconfig -a
```
```
bluetoothctl
[bluetooth]# show
[bluetooth]# devices
[bluetooth]# info <mac addr of any device you have problems with>
```
```
rfkill list
Necessary bluetooth log files in debug mode as per below
```
