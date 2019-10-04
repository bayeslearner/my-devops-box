#!/bin/bash

INSTALL_DIR="/home/vagrant/awx"
CUSTOM_AWX_CONFIG=/vagrant/awx_inventory

if ! [ -x "$(command -v docker)" ] ; then
    echo "Docker needs to be installed before this script!"
    exit 1
fi

apt-get install -yq python-pip
pip install docker-compose

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ] ; then
    pip install ansible
fi

git clone https://github.com/ansible/awx.git ${INSTALL_DIR}

if [ -f ${CUSTOM_AWX_CONFIG} ] ; then
    cp ${CUSTOM_AWX_CONFIG} ${INSTALL_DIR}/installer/inventory
fi

pushd ${INSTALL_DIR}/installer
ansible-playbook -i inventory install.yml
popd
