datacenter = "obs"

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

advertise {
 http = "{{vars.ansible_all_ipv4_addresses[1]}}"
 rpc = "{{vars.ansible_all_ipv4_addresses[1]}}"
 serf = "{{vars.ansible_all_ipv4_addresses[1]}}"
}
server {
  enabled          = true
  bootstrap_expect = 3
}

// client {
//   enabled = true
//   servers =  [ "{{ vars.groups.servers | map('quote') | join('", "') }}"]
// }
