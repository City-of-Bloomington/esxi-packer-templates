#!/bin/bash

sudo apt-get update
sudo apt-get -y dist-upgrade

# systemd-resolved is just more trouble than it's worth in our environment
# it constantly causes problems with our locally hosted DNS
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm -rf /etc/resolv.conf
sudo mv /tmp/resolv.conf /etc/resolv.conf

# comment out the section that auto-clears the /tmp dir on first boot
# this makes VMware guest customization break if not done
sudo sed -i '/D \/tmp/s/^/#/g' /usr/lib/tmpfiles.d/tmp.conf