### Reduce swap and extend other LVM module

```bash
# Disable swap temporarly.
swapoff -a

# Reduce swap paritition.
lvreduce /dev/superbacon-vg/swap_1 -L -67G

# Extend LVM root paritition.
lvextend /dev/superbacon-vg/root -L +67G

# Extend actual partition size.
resize2fs /dev/superbacon-vg/root

# Recreate swap partition
mkswap /dev/superbacon-vg/swap_1

# Re-enable swap partition
swapon -a

----------------- Mount partition from existing VG/LV -----------------
# Create an ext4 partition.
mkfs.ext4 /dev/vg-storage/lv-storage

# Mount the partition to test.
mount -t ext4 /dev/vg-storage/lv-storage /mnt

# Mount in /etc/fstab
/dev/mapper/vg--storage-lv--storage /storage    ext4    defaults,nofail        0    1
```


```
7  echo "deb http://download.proxmox.com/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
    8  wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg
    9  apt update && apt dist-upgrade
   10  apt install proxmox-ve postfix open-iscsi
   11  clear
   12  shutdown -r now
   13  mount /dev/sdb1 /storage
   14  mkdir /storage
   15  mount /dev/sdb1 /storage
   16  mount /dev/sdb /storage
   17  mount -t ext4 /dev/sdb /storage
   18  dmesg | tail
   19  fdisk -l
   20  lvdisplay 
   21  vgdisplay 
   22  vgscan 
   23  fdisk -l
   24  clear
   25  vgdisplay 
   26  lvmdiskscan 
   27  vgcreate 
   28  vgcreate /dev/sdb1
   29  pvs
   30  vgcreate vg-storage /dev/sdb1
   31  vgdisplay 
   32  man lvcreate 
   33  lvcreate -n storage -l 100%FREE vg-storage
   34  lvdisplay 
   35  clear
   36  mkfs.ext4 /dev/vg-storage/storage
   37  lvdisplay 
   38  man mount
   39  man mount
   40  man mount
   41  mount -t ext4 /dev/vg-storage/storage /storage
   42  cd /storage
   43  mkdir tata
   44  ls
   45  rm tata
   46  rm -rf tata
   47  clear
   48  exit
   49  history
```