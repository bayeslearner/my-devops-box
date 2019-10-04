#!/bin/bash

echo "hosts file setup..."

sudo echo "192.168.10.21 web01" | sudo tee -a /etc/hosts
sudo echo "192.168.10.31 api01" | sudo tee -a /etc/hosts
sudo echo "192.168.10.41 worker01" | sudo tee -a /etc/hosts
sudo echo "192.168.10.51 consumer01" | sudo tee -a /etc/hosts  
