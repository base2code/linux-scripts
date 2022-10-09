#!/bin/bash
#Install Certbot via snapd (over apt) and create symlink
sudo apt install snapd -yqq
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
