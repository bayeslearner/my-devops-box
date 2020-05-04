#!/bin/bash -e

# Installs ansible along with other components
apt-get install -y python3-pip python3-testresources
ln -sf /usr/bin/python3 /usr/bin/python
ln -sf /usr/bin/pip3 /usr/bin/pip
pip install --upgrade pip
pip install --upgrade --ignore-installed --requirement /vagrant/requirements.txt

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
