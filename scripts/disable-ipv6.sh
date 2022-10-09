#!/bin/bash
#Disables IPv6
sudo echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
sudo echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
sudo sysctl -p
