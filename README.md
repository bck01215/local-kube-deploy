# Usage
## Testing
### Loading Environment
Recommended to use [direnv](https://direnv.net/). Alternatively manually load the [.envrc](./.envrc).

[Preston Gibbs](https://lu-is.slack.com/team/U01MHTFUXB6) do NOT modify .envrc to fit fish. Modify fish to fit .envrc or use direnv

### Vagrant Setup

Install [libvirt for vagrant](https://vagrant-libvirt.github.io/vagrant-libvirt/).

After loading env vars run the following:
```bash
vagrant box add --provider libvirt fedora/39-cloud-base
vagrant up
vagrant ssh-config # compare with inventory.ini for port and key settings
vagrant ssh-config > ssh.cfg # for ansible
```
