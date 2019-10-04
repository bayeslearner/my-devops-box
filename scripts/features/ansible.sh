#!/bin/bash -eu

# install ansible
if ! [ -x "$(command -v ansible)" ] ; then
    add-apt-repository ppa:ansible/ansible
    apt-get update
    apt-get install -y ansible
else
    echo "Ansible was already installed, skipping..."
    exit 0
fi
