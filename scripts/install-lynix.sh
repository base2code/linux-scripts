#!/bin/bash
wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
sudo apt-get -y update # Update the package list
sudo apt install lynis -y # Install Lynis
sudo lynis show version
