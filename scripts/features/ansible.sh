#!/bin/bash -eu

if ! [ -x "$(command -v ansible)" ] ; then
    apt-get install -y python-pip
    pip install ansible 
    ansible --version
    pip install molecule yamllint ansible-lint docker-py
    molecule --version
else
    echo "Ansible was already installed, skipping..."
    exit 0
fi

# refresh permissions
chown -R vagrant:vagrant /home/vagrant