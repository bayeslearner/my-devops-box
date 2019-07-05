#!/bin/bash -eu

# install ansible
if ! [ -x "$(command -v ansible)" ] ; then
    apt-add-repository --yes --update ppa:ansible/ansible
    apt-get update
    apt-get install -y ansible > /dev/null
else
    echo "Ansible was already installed, skipping..."
    exit 0
fi
