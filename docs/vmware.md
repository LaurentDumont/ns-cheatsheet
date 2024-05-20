    1  df -h
    2  cd /storage/log/
    3  ls
    4  cd vmware/
    5  ls
    6  du -a /var | sort -n -r | head -n 10
    7  du h-a /var | sort -n -r | head -n 10
    8  df -h
    9  cd ..
   10  du h-a /var | sort -n -r | head -n 10
   11  cd /var/log/
   12  ls
   13  du -ha /var | sort -n -r | head -n 10
   14  ls -alh
   15  cd vmware
   16  ls
   17  du -ha /var | sort -n -r | head -n 10
   18  ls -alh
   19  du -ha /var | sort -n -r | head -n 100
   20  ls -alh /storage/log/vmware/sso/tomcat/
   21  du -hs /storage/log/vmware/sso/tomcat/
   22  du -hs /storage/log/vmware
   23  du -hs /storage/log/vmware/eam/
   24  du -hs /storage/log/vmware/lookupsvc/
   25  du -hs /storage/log/vmware/lookupsvc/tomcat/
   26  ls -alh /storage/log/vmware/lookupsvc/tomcat/
   27  du -hs /storage/log/vmware/lookupsvc/tomcat/*
   28  rm /storage/log/vmware/lookupsvc/tomcat/localhost_access.2021-*
   29  df -h
   30  /usr/lib/vmware-vmca/bin/certificate-manager
   31  cat /var/log/vmware/vmcad/certificate-manager.log
   32  ping colo.coldnorthadmin.com
   33  /usr/lib/vmware-vmca/bin/certificate-manager
   34  ping 10.199.199.1
   35  dig google.ca
   36  dig colo.coldnorthadmin.com
   37  dig vcenter.colo.coldnorthadmin.com
   38  clear
   39  /usr/lib/vmware-vmca/bin/certificate-manager
   40  cd/etc/vmware-sso
   41   cd /etc/vmware-sso
   42  ls
   43  cd keys/
   44  ls
   45  history | grep vcenter
   46  ls
   47  ls -alh
   48  cat ssoserverRoot.crt 
   49  htop
   50  top
   51  service-control --status
   52  toptop
   53  top
   54  service-control --status
   55  watch -n 1 "service-control --status"
   56  cd /etc/ssl/certs
   57  ls
   58  ls -alh
   59  service-control
   60  service-control --help
   61  service-control --start vmware-vapi-endpoint 
   62  service-control
   63  service-control --list-status
   64  service-control --status
   65  /usr/lib/vmware-vmafd/bin/dir-cli
   66  cd /usr/lib/vmware-vmafd/bin/dir-cli
   67  tail -n 100 /var/log/vmware/vpxd/vpxd.log 
   68  date
   69  tail -n 100 /var/log/vmware/vpxd/vpxd.log 
   70  grep -ir ssl /var/log/vmware/vpxd/vpxd.log 
   71  cd /etc/vm
   72  cd /etc/vmware
   73  ls
   74  cat backup/
   75  cat .buildInfo 
   76  /usr/lib/vmware-vmca/bin/certificate-manager
   77  cd /tmp/vmware-root
   78  ls
   79  cd /var/log/vmware
   80  ls
   81  tail -n 100 vpxd/vpxd.log 
   82  service-control --status
   83  /usr/lib/vmware-vmafd/bin/vecs-cli entry list --store TRUSTED_ROOTS --text | less
   84  usr/lib/vmware-vmafd/bin/vecs-cli entry list --store MACHINE_SSL_CERT --text | less
   85  usr/lib/vmware-vmafd/bin/vecs-cli entry list --store MACHINE_SSL_CERT --text
   86  /usr/lib/vmware-vmafd/bin/vecs-cli entry list --store MACHINE_SSL_CERT --text
   87  /usr/lib/vmware-vmafd/bin/vecs-cli entry list --store vpxd --text | less
   88  /usr/lib/vmware-vmafd/bin/vecs-cli entry list --store vsphere-webclient --text | less
   89  cd /tmp/
   90  vi fixsts.sh
   91  chmod +x fixsts.sh 
   92  ./fixsts.sh 
   93  service-control --stop --all
   94  service-control --start --all
   95  top
   96  cd /var/log/vmware/vapi/
   97  ls
   98  cd endpoint/
   99  ls
  100  tail -n 100 -f endpoint.log
  101  /usr/lib/vmware-vmca/bin/certificate-manager
  102  tail -n 100 /var/log/vmware/vmcad/certificate-manager.log
  103  ping vcenter.colo.coldnorthadmin.com
  104  reset
  105  tail -n 100 /var/log/vmware/vmcad/certificate-manager.log
  106  /usr/lib/vmware-vmca/bin/certificate-manager
  107  cat /etc/hostname 
  108  /usr/lib/vmware-vmca/bin/certificate-manager
  109  tail -n 100 /var/log/vmware/vmcad/certificate-manager.log
  110  python /usr/lib/vmidentity/tools/scripts/lstool.py list --url http://localhost:7080/lookupservice/sdk | less
  111  python /usr/lib/vmidentity/tools/scripts/lstool.py list --url http://vcenter.colo.coldnorthadmin.com:7080/lookupservice/sdk | less
  112  ls /usr/lib/vmidentity/tools/scripts/lstool.py
  113  ls /usr/lib/vmware-lookupsvc/tools/lstool.py 
  114  python /usr/lib/vmware-lookupsvc/tools/lstool.py  list --url http://vcenter.colo.coldnorthadmin.com:7080/lookupservice/sdk | less
  115  clear
  116  cd /usr/lib/vmware/site-packages/cis
  117  ls
  118  cp certificateManagerHelper.py certificateManagerHelper.py.bak
  119  vi certificateManagerHelper.py
  120  reset
  121  /usr/lib/vmware-vmca/bin/certificate-manager
  122  clear
  123  htop
  124  clear
  125  df -h
  126  history
