# Testing

## Vagrant setup

```bash
vagrant box add --provider virtualbox generic/centos9s
VAGRANT_EXPERIMENTAL="disks" vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
```

## Ansible

Example ansible init commands

```bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook main.yml -i inventory.ini --vault-password-file=~/.vault_pass.txt 

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook main.yml -i inventory.ini --tags=install_seaweed --vault-password-file=~/.vault_pass.txt 
```

## Nomad

UI can accessed via port 4646. This is automatically forwarded from server1

## Consul

UI can accessed via port 8500. This is automatically forwarded from server1

## Seaweed

Exists on the master seaweed node port 9333. To find the master run the following curl on a server node:

```bash
curl http://localhost:9333/cluster/status?pretty=y
```

### Troubleshooting

After a catastrophe (All masters, volumes, and filers fail) it may be necessary to restart all services. Order does matter.

```bash

systemctl restart weed-mster.service
systemctl restart weed-volume.service
systemctl restart weed-filer.service

```
