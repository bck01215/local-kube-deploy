# Testing

Vagrant setup

```bash
vagrant box add --provider virtualbox generic/rhel8
vagrant box add --provider virtualbox generic/fedora36 # Instead of RHEL 9 because of package management issues
vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
```
