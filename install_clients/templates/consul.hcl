datacenter = "obs"

data_dir = "/opt/consul"

ui_config{
  enabled = false
}

server = false
client_addr = "0.0.0.0"

advertise_addr = "{{vars.ansible_eth1.ipv4.address}}"



# J2 template out to all servers
# For all hosts in the inventory
retry_join = [ "{{ vars.groups.servers | map('quote') | join('", "') }}"]
