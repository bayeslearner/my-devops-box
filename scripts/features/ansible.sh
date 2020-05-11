#!/bin/bash -e

# Install pip from source
curl -skL https://bootstrap.pypa.io/get-pip.py | python3

# Update symlinks
ln -sf /usr/bin/python3 /usr/bin/python
ln -sf /usr/bin/pip3 /usr/bin/pip

# Installs ansible along with other components
apt-get install -y python3-testresources
pip install --upgrade --ignore-installed --requirement /vagrant/requirements.txt

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
