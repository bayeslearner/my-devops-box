#!/bin/bash -eu

# install ansible
if ! [ -x "$(command -v ansible)" ] ; then
    # add-apt-repository --yes ppa:ansible/ansible-2.8
    # apt-get update
    # apt-get install -y ansible
    apt-get install -y python-pip
    pip install ansible
else
    echo "Ansible was already installed, skipping..."
    exit 0
fi

# refresh permissions
chown -R vagrant:vagrant /home/vagrant