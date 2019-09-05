#!/bin/bash

INSTALL_DIR="/home/vagrant/awx"

if ! [ -x "$(command -v docker)" ] ; then
    echo "Docker needs to be installed before this script!"
    exit 1
fi

apt-get install python-pip
pip install docker-compose

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ] ; then
    pip install ansible
fi

git clone https://github.com/ansible/awx.git ${INSTALL_DIR}
pushd ${INSTALL_DIR}/installer
sed -i -r "s/#?project_data_dir=.*/project_data_dir=\\/home\/vagrant\/ansible/g" inventory
ansible-playbook -i inventory install.yml
popd
