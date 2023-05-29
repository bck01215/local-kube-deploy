## Testing

Vagrant setup

```bash
vagrant box add --provider virtualbox generic/rhel8
vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
```

Every vagrant host then needs to have this added to /etc/hosts

```ini
192.168.33.33 server1
192.168.33.34 server2
192.168.33.35 server3
```
