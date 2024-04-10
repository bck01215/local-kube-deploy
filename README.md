# Usage
## Testing
### Loading Environment
Recommended to use [direnv](https://direnv.net/). Alternatively manually load the [.envrc](./.envrc).

[Preston Gibbs](https://lu-is.slack.com/team/U01MHTFUXB6) do NOT modify .envrc to fit fish. Modify fish to fit .envrc or use direnv

### Vagrant Setup

Install [libvirt for vagrant](https://vagrant-libvirt.github.io/vagrant-libvirt/).

After loading env vars run the following:
```bash
vagrant box add --provider virtualbox generic/fedora38
vagrant up server1
vagrant up server2 server3
vagrant ssh-config > ssh.cfg
mkdir .kube
ssh -F ssh.cfg vagrant@server1 'sudo cat /root/.kube/config' > .kube/config
❯ sed -i 's/127.0.0.1/192.168.57.33/g' .kube/config 
```
### Kube Config Setup
You'll need to copy the kube config from server1. 
There are many ways to proceed from here.
Personally I extracted the cluster, context, and user section. 
I then modified the names to make them appropriate. The context is expected to be called `k3s` to fit the .envrc.

#### TODO: 
    - [ ] Automate copying data to kube/config