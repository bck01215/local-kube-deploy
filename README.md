# Usage
## Testing
### Loading Environment
Recommended to use [direnv](https://direnv.net/). Alternatively manually load the [.envrc](./.envrc).

[Preston Gibbs](https://lu-is.slack.com/team/U01MHTFUXB6) do NOT modify .envrc to fit fish. Modify fish to fit .envrc or use direnv

### Vagrant Setup

Install [libvirt for vagrant](https://vagrant-libvirt.github.io/vagrant-libvirt/).

After loading env vars run the following:
```bash
vagrant box add --provider virtualbox generic/centos9s
vagrant up server1
vagrant up server2 server3
vagrant ssh-config > ssh.cfg
mkdir .kube
ssh -F ssh.cfg vagrant@server1 'sudo cat /root/.kube/config' > .kube/config
sed -i 's/127.0.0.1/192.168.57.33/g' .kube/config 
```
