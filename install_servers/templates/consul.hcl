datacenter = "obs"

data_dir = "/opt/consul"

ui_config{
  enabled = true
}

server = true
client_addr = "0.0.0.0"

advertise_addr = "{{vars.inventory_hostname}}"

bootstrap_expect=3


# J2 template out to all servers
# For all hosts inventory
retry_join = [ "{{ vars.groups.servers | map('quote') | join('", "') }}"]