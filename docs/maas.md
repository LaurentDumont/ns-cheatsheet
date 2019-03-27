## Adding a custom power provider for MAAS.


### Proxmox Script - source https://bugs.launchpad.net/maas/+bug/1805799
```python
# Copyright 2018 Wojciech Rakoniewski  
# This software is licensed under the
# GNU Affero General Public License version 3 (see the file LICENSE).
#
# tested on Proxmox VE 5.2-11 but should work with any version
# libraries: proxmoxer
#   tested with version 1.02 installed using apt

"""Proxmox Power Driver for MAAS"""

__all__ = [
        "ProxmoxError",
        "ProxmoxPowerDriver"
        ]

from provisioningserver.drivers import (
    make_ip_extractor,
    make_setting_field,
    SETTING_SCOPE,
)
from provisioningserver.drivers.power import (
    PowerDriver,
    PowerError
)

try:
    from proxmoxer import ProxmoxAPI
    PROXMOXER_IMPORTED = True
except ImportError:
    PROXMOXER_IMPORTED = False

PROXMOX_YES="y"
PROXMOX_NO="n"

PROXMOX_VALIDATE_SSL_CHOICES = [
    [PROXMOX_YES, "Yes"],
    [PROXMOX_NO, "No"]]

class ProxmoxError(PowerError):
    """Failure communicating to proxmox """

class ProxmoxPowerDriver(PowerDriver):

    name = 'proxmox'
    chassis = True
    description = "Proxmox (virtual systems)"
    settings = [
        make_setting_field(
            'power_vm_name', "VM id or name", required=True,
            scope=SETTING_SCOPE.NODE),
        make_setting_field('power_address', 
            "Proxmox host name or ip", required=True),
        make_setting_field('power_user', 
            "Proxmox username (user@realm)", required=True),
        make_setting_field(
            'power_pass', "Proxmox password", field_type='password',
            required=True),
        make_setting_field('power_ssl_validate', "Validate ssl", 
            field_type='choice', required=True, 
            choices=PROXMOX_VALIDATE_SSL_CHOICES, default=PROXMOX_NO),
    ]
    ip_extractor = make_ip_extractor('power_address')

    def detect_missing_packages(self):
        if not PROXMOXER_IMPORTED:
            return ["python3-proxmoxer"]
        return []

    def power_on(self, system_id, context):
        """Power on Proxmox node."""
        vm=self.__proxmox_login(system_id,context)
        vm.status.start.post();

    def power_off(self, system_id, context):
        """Power off Proxmox node."""
        vm=self.__proxmox_login(system_id,context)
        vm.status.stop.post();

    def power_query(self, system_id, context):
        """Power query Proxmox node."""
        vm=self.__proxmox_login(system_id,context)
        ncd=vm.status.current.get()

        if ncd['status'] == 'running':
            return "on"
        else:
            return "off"


    def __proxmox_login(self,system_id,context):
        """Login to proxmox server."""

        api_host = context.get('power_address')
        api_user = context.get('power_user')
        api_password = context.get('power_pass')
        vm_id = context.get('power_vm_name')
        api_ssl_val = (context.get('power_validate_ssl')==PROXMOX_YES)
       
        try:
            api = ProxmoxAPI(api_host, user=api_user, 
                    password=api_password, verify_ssl=api_ssl_val)

            con_vm=None
            for vm in api.cluster.resources.get(type="vm"):
                if (str(vm['vmid'])==vm_id) or (vm['name']==vm_id):
                    con_vm=vm
                    break

        except Exception:
            raise ProxmoxError(
                    "Can't connect to proxmox cluster %s" % (api_host))

        if con_vm is None:
            """vm not found"""
            raise ProxmoxError(
                    "Virtual machine %s not found on proxmox cluster %s" % (vm_id, api_host))

        #extract node object
        vm_obj=getattr(getattr(getattr(api.nodes,con_vm['node']),
            con_vm['type']),
            str(con_vm['vmid']))

        return vm_obj
```

### Location of the power scripts for MAAS.
```
/usr/lib/python3/dist-packages/provisioningserver/drivers/power/proxmox.py
/usr/lib/python3/dist-packages/provisioningserver/drivers/power/registry.py
```

### Edit registry.py and add the following lines to the bottom of the import section.
```
from provisioningserver.drivers.power.proxmox import ProxmoxPowerDriver
```

### Add the following line to the bottom of the power_drivers array.

```
ProxmoxPowerDriver(),
```

```
# Register all the power drivers.
power_drivers = [
    AMTPowerDriver(),
    APCPowerDriver(),
    DLIPowerDriver(),
    FenceCDUPowerDriver(),
    HMCPowerDriver(),
    IPMIPowerDriver(),
    ManualPowerDriver(),
    MoonshotIPMIPowerDriver(),
    MSCMPowerDriver(),
    MicrosoftOCSPowerDriver(),
    NovaPowerDriver(),
    RECSPowerDriver(),
    SeaMicroPowerDriver(),
    UCSMPowerDriver(),
    VirshPowerDriver(),
    VMwarePowerDriver(),
    WedgePowerDriver(),
    ProxmoxPowerDriver(),
]
```

### Restart the rack controller.

```
systemctl restart maas-rackd
```