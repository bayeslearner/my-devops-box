#!/bin/bash -e

# Install python packages
apt-get update
apt-get install -y python3 python3-apt python3-setuptools python3-testresources

# Update symlinks
ln -sf /usr/bin/python3 /usr/bin/python
ln -sf /usr/local/bin/pip3 /usr/bin/pip

# Install pip from source
curl -skL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python /tmp/get-pip.py --no-setuptools

# Installs ansible along with other components
pip install --upgrade --ignore-installed --requirement /vagrant/requirements.txt

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
