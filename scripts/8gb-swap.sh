#!/bin/sh
#CAUTION: Creates 8GB of swap in /swapfile (overwriting and creating new)
sudo dd if=/dev/zero of=/swapfile bs=8192 count=1048576
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
