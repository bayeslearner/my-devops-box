#!/bin/bash -eux

INSTALL_DIR="/home/vagrant/awx"
CUSTOM_AWX_CONFIG=/vagrant/awx_inventory
VERSION=${AWX_VERSION:-"7.0.0"}

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

wget -qO /tmp/awx.tar.gz https://github.com/ansible/awx/archive/${VERSION}.tar.gz
mkdir -p ${INSTALL_DIR}
tar -C ${INSTALL_DIR} -xzf /tmp/awx.tar.gz --strip-components 1

if [ -f ${CUSTOM_AWX_CONFIG} ] ; then
    cp ${CUSTOM_AWX_CONFIG} ${INSTALL_DIR}/installer/inventory
fi

echo "AWX version $(cat ./{$INSTALL_DIR}/VERSION) is going to be installed..."
pushd ${INSTALL_DIR}/installer
ansible-playbook -i inventory install.yml
popd
