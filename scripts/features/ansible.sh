#!/bin/bash -eu

# Installs ansible along with other components
apt-get install -y python3 python3-pip
pip3 install --upgrade --ignore-installed --requirement /vagrant/requirements.txt

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
