# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.network "private_network", ip: "192.168.100.11"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
end
