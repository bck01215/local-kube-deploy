datacenter = "obs"

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

advertise {
 http = "{{vars.ansible_eth1.ipv4.address}}"
 rpc = "{{vars.ansible_eth1.ipv4.address}}"
 serf = "{{vars.ansible_eth1.ipv4.address}}"
}
server {
  enabled          = true
  bootstrap_expect = 3
}

// client {
//   enabled = true
//   servers =  [ "{{ vars.groups.servers | map('quote') | join('", "') }}"]
// }
