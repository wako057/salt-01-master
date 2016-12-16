# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
	# v.gui = true
    v.name = "salt-master-01"
    v.memory = 2048
    v.cpus = 2

  end
  
  config.vm.hostname = "salt-master-01"
  config.vm.box = "debian/jessie64"
  config.vm.box_version = "8.6.1"
  
  config.vm.provision :shell, path: "bootstrap_master.sh"

  config.vm.network "private_network", ip: "10.0.0.50"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  
  
  config.vm.post_up_message = "La vm est prete"
end