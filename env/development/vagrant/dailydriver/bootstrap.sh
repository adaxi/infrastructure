#!/usr/bin/env bash

sudo apt-get update
sudo tasksel install gnome-desktop --new-install
sudo /etc/init.d/gdm3 start
