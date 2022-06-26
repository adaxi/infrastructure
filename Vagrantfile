# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo '#!/bin/bash

# This script cannot be run by the shell provisioner
# the script complains that it cannot access /dev/tty

set -x
export DEBIAN_FRONTEND=noninteractive
sudo apt update && sudo apt install gnome-control-center gnome-maps -y && sudo tasksel install gnome-desktop --new-install && sudo /etc/init.d/gdm3 start
' > /home/vagrant/install-gnome && chmod +x /home/vagrant/install-gnome
echo 'To install gnome: vagrant ssh daily then run ./install-gnome'
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
  config.vm.define "media" do |c|
    c.vm.box = "debian/bullseye64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "media.local"
    c.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Mediaserver (media)"
    end
  end

  config.vm.define "daily" do |c|
    c.vm.box = "debian/bullseye64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "daily.local"
    c.vm.provision :shell, inline: $script
    c.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Daily Driver (daily)"
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "vm" do |c|
    c.vm.box = "debian/bullseye64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "vm.local"
    c.vm.network "public_network", ip: "10.68.0.50", bridge: "enp4s0"
    c.vm.provider "virtualbox" do |v|
      v.name = "Virtual Machine (vm)"
      v.memory = 2048
      v.cpus = 2
    end
    c.vm.provision "ansible" do |ansible|
      ansible.playbook = "vmserver.yml"
      ansible.inventory_path = "env/development/inventory"
    end
  end

  # export SSH_AUTH_SOCK="" in case of:
  #  kube: Warning: Connection reset. Retrying...
  #  kube: Warning: Remote connection disconnect. Retrying...
  config.vm.define "kube" do |c|
    c.vm.box = "ubuntu/focal64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "kube.local"
    c.vm.network "public_network", ip: "10.68.0.51", bridge: "enp4s0"
    c.vm.provider "virtualbox" do |v|
      v.name = "Virtual Machine (vm)"
      v.memory = 8192
      v.cpus = 2
    end
    c.vm.provision "ansible" do |ansible|
      ansible.playbook = "kubernetesserver.yml"
      ansible.inventory_path = "env/development/inventory"
    end
  end
  

  config.vm.define "web" do |c|
    c.vm.box = "debian/bullseye64"
    c.vm.synced_folder '.', '/vagrant', disabled: true
    c.vm.hostname = "web.local"
    c.vm.provider "virtualbox" do |v|
      v.name = "Webserver (web)"
    end
    c.vm.provision "ansible" do |ansible|
      ansible.playbook = "webserver.yml"
      ansible.inventory_path = "env/development/inventory"
    end
  end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network", bridge: "enp4s0"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

end
