# Testing

## Vagrant setup

```bash
vagrant box add --provider virtualbox generic/rhel8
vagrant box add --provider virtualbox generic/fedora34 # Instead of RHEL 9 because of package management issues
vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
```
## Nomad Testing
UI can accessed via port 4646. This is automatically forwarded from server1

## CONSUL Testing
UI can accessed via port 8500. This is automatically forwarded from server1
