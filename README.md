Infrastructure
==============

This repository holds configuration for the different machines I own.

To launch the configuration:

```sh
ansible-playbook -i env/<environment>/inventory all.yml
```

Discover, modify and test using vagrant
---------------------------------------

A development and a production environment are available. The production environment 
are my actual machines. The development machines are Vagrant based.

Example for mediaserver:

```sh
mkdir infrastructure && cd infrastructure

git clone git://github.com/adaxi/infrastructure.git .

git clone git://github.com/ansible/ansible.git --recursive
source ansible/hacking/env-setup

cd env/development/vagrant/mediaserver
vagrant up
cd -

ssh-copy-id vagrant@mean

ansible-playbook -i env/development/inventory mediaservers.yml
```


Media Server
------------

My media server is based on a Debian Wheezy contains the following components:
 * Open Media Vault: NAS management
 * Sabnzbdplus: Usenet download
 * Sickbeard: TV Series episode management
 * Plex Media Server: Streams media to all my devices
 * Plex Home Theater: Media center
 
 
Daily Driver
------------

My daily drivers consists of a Debian Jessie distribution. It contains all the tools
I use regularly. It is also pre-configured for my needs: my dotfiles are included.







