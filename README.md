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

vagrant up mediaserver

ssh-copy-id vagrant@mean # password is "vagrant"

ansible-playbook -i env/development/inventory mediaserver.yml
```


Media Server
------------

My media server is based on a Debian Wheezy contains the following components:
 * Open Media Vault: NAS management
 * Sabnzbdplus: Usenet download
 * Sickbeard: TV Series episode management
 * Plex Media Server: Streams media to all my devices
 * Plex Home Theater: Media center


Before reinstalling your system make sure that the following items are safe:
 * /etc/mdadm.conf

After installing the production system:
 * Install LVM over LUKS over RAID5.
 * ```mv /media/raid/* /media/<uuid> && rm -rf /media/raid && ln -sf /media/<uuid> /media/raid```
 * Backup ```/etc/mdadm.conf```
 * Add media libraries to Plex Media Server
 * Configure addns in OMV


Daily Driver
------------

My daily drivers consists of a Debian Jessie distribution. It contains all the tools
I use regularly. It is also pre-configured for my needs: my dotfiles are included.

Before reinstalling your system make sure that the following items are safe:
 * SSH keys
 * GPG keys
 * Keepass2 database

When testing in the development environement, you need to login and run:
./install-gnome.
For some reason it requires /dev/tty and I have not found how to bypass
this. Either I find a way to fix it, or I build a box with gnome included.


Webserver
---------

Hosts my websites with a Nginx + ( PHP-FPM | Node ) + Maria DB stack.
Hosts my apt repository.

Before reinstalling your system make sure that the following items are safe:
 * GPG keys (aptly)

When installing the webserver you need to place the GPG keys for your repository
into ```env/<environment>/keys```

To create new GPG keys:
```sh
sudo apt-get install gnupg
gpg --gen-key # copy the key id
gpg --export-secret-keys --armor <keyid> > env/<environment>/private.gpg.key
gpg --export --armor 61B1BA69 > env/<environment>/public.gpg.key

```

Place a backup of the adaxisoft database in ```/backups/adaxisoft.sql``` for it to be restored.
Place a backup of the lusoleaves database in ```/backups/lusoleaves.sql``` for it to be restored.
Place a backup of the lusoleaves products in ```/backups/products``` for it to be restored.

After installing the production system:
 * Add the debian packages to the repository



