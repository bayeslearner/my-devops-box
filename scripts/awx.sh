#!/bin/bash

INSTALLDIR=/home/vagrant/awx

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ] ; then
    echo "Ansible needs to be installed before this script!"
    exit 1
fi

if ! [ -x "$(command -v docker)" ] ; then
    echo "Docker needs to be installed before this script!"
    exit 1
fi

git clone https://github.com/ansible/awx.git ${INSTALLDIR}
pushd ${INSTALLDIR}/installer
ansible-playbook -i inventory install.yml
popd
