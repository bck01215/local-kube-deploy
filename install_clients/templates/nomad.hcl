datacenter = "obs"

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"
plugin_dir = "/opt/nomad/data/plugins"
advertise {
 http = "{{vars.ansible_eth1.ipv4.address}}"
 rpc = "{{vars.ansible_eth1.ipv4.address}}"
 serf = "{{vars.ansible_eth1.ipv4.address}}"
}
server {
  enabled = false
}

client {
  enabled = true
  servers =  [ "{{ vars.groups.servers | map('quote') | join('", "') }}"]
{%for item in apps %}  

  host_volume "vol-{{item}}" {
    path = "/opt/nomad/data/volumes/{{item}}"
    read_only = false
  }
{% endfor %}
}

plugin "nomad-driver-podman" {
  config {
    socket_path = "unix:///run/podman/podman.sock"
    volumes {
      enabled      = true
    }
  }
}
consul {
  address = "127.0.0.1:8500"
}

