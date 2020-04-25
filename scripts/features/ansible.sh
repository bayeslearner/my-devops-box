#!/bin/bash -e

# Installs ansible along with other components
apt-get install -y python3-pip
ln -sf /usr/bin/python3 /usr/bin/python
ln -sf /usr/bin/pip3 /usr/bin/pip
pip install --upgrade pip

if ! [ -x "$(command -v ansible)" ] ; then
    sudo -u vagrant pip install --upgrade --ignore-installed --requirement /vagrant/requirements.txt
fi

# Display current ansible version
ansible --version
# Display current molecule version
molecule --version
