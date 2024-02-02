# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.define :server1 do |server1|
    server1.vm.box = "generic/centos9s"
    server1.vm.hostname = "server1"
    server1.vm.provision "shell", path: "vagrant_startup.sh"
    server1.vm.network :private_network,
        :ip => '192.168.57.33'
    server1.vm.provider :libvirt do |domain|
        domain.memory = 4096
        domain.cpus = 2
        domain.storage :file, :size => '20G', :type => 'qcow2'
    end
  end
  config.vm.define :server2 do |server2|
    server2.vm.box = "generic/centos9s"
    server2.vm.hostname = "server2"
    server2.vm.provision "shell", path: "vagrant_startup_secondary.sh"
    server2.vm.network :private_network,
        :ip => '192.168.57.34'
    server2.vm.provider :libvirt do |domain|
        domain.memory = 4096
        domain.cpus = 2
        boot_network = {'network' => 'foreman_managed2'}
        domain.storage :file, :size => '20G', :type => 'qcow2'
        domain.boot boot_network
        domain.boot 'hd'
    end
  end
  config.vm.define :server3 do |server3|
    server3.vm.box = "generic/centos9s"
    server3.vm.hostname = "server3"
    server3.vm.provision "shell", path: "vagrant_startup_secondary.sh"
    server3.vm.network :private_network,
        :ip => '192.168.57.35'
    server3.vm.provider :libvirt do |domain|
        domain.memory = 4096
        domain.cpus = 2
        boot_network = {'network' => 'foreman_managed3'}
        domain.storage :file, :size => '20G', :type => 'qcow2'
        domain.boot boot_network
        domain.boot 'hd'
    end
  end
end