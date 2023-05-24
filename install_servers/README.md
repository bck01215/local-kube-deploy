## Testing

Vagrant setup

```bash
vagrant box add --provider virtualbox generic/rhel8
vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
```
