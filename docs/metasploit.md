## Metasploit plugins

### How to use an ssh login as a msf session
```
use auxiliary/scanner/ssh/ssh_login
set rhosts 10.10.127.204
set username typhoon
set password 789456123

# show sessions
sessions

msf5 post(multi/recon/local_exploit_suggester) > sessions

Active sessions
===============

  Id  Name  Type         Information                               Connection
  --  ----  ----         -----------                               ----------
  1         shell linux  SSH typhoon:789456123 (10.10.127.204:22)  10.9.179.67:40461 -> 10.10.127.204:22 (10.10.127.204)
                  
# use specific session
set session 1
```

### Use the msf exploit suggestion
```
use post/multi/recon/local_exploit_suggester
exploit
```