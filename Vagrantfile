# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo '#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo tasksel install gnome-desktop --new-install && sudo /etc/init.d/gdm3 start
' > /home/vagrant/install-gnome && chmod +x /home/vagrant/install-gnome
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # This file configures a test environment to run a mediaserver machine. 
  # The vagrant machine must be accessible through ssh, uncomment either
  # the public or private network line, then add the IP address in the
  # mediaservers section of the inventory file.
  # 
  # For a complete reference, please see the online documentation at 
  # vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.define "mean" do |c| 
    c.vm.box = "debian/contrib-jessie64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "mean.local"
    c.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Mediaserver (mean)"
    end
  end

  config.vm.define "zero" do |c|
    c.vm.box = "debian/contrib-jessie64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "zero.local"
    c.vm.provider "virtualbox" do |v|
      v.name = "Webserver (zero)"
    end
    c.vm.provision "ansible" do |ansible|
      ansible.playbook = "webserver.yml"
      ansible.inventory_path = "env/development/inventory"
    end
  end
  
  config.vm.define "double" do |c|
    c.vm.box = "debian/contrib-jessie64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "double.local"
    c.vm.provision :shell, inline: $script
    c.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Daily Dirver (double)"
    end
    c.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  end




  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

end
