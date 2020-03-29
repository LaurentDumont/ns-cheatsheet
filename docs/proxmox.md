### User and permission management
#### Full admin over specific VMs
```
# Pool + VM are inside that pool.
# Assume that the user already exists and we want to allow permissions on a specific group of VM.
pveum groupadd po-vm-group -comment "PO VMs only"
pveum aclmod /pool/PO-POOL-1/ -group po-vm-group -role PVEAdmin
pveum usermod riyoth@pam -group po-vm-group
```