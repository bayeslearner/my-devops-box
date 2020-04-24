#!/bin/bash -e

# Installs ansible along with other components
apt-get install -y python3-pip
ln -sf /usr/bin/python3 /usr/bin/python
pip3 install --upgrade --ignore-installed --requirement /vagrant/requirements.txt
ln -sf /usr/bin/pip3 /usr/bin/pip

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
