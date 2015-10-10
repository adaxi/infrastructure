Personal Inventory and Configuration 
====================================

This repository contains my configuration for the different machines I own.
It currently contains the configuration for my mediaserver.


To lauch the configuration:
```
ansible-playbook -i env/<environment>/inventory site.yml
```

A development and a production environment are available. The production environment 
are my actual machines. The development machines are Vagrant based.

Mediaserver
-----------

The media server is based on a Debian Wheezy contains the following components:
 * Open Media Vault
 * Sabnzbdplus
 * Sickbeard
 * Plex Media Server
 * Plex Home Theater




