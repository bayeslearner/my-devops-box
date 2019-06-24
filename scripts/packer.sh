#!/bin/bash -eu

# install packer
if ! which packer > /dev/null ; then
    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
    unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
    rm packer_${PACKER_VERSION}_linux_amd64.zip
else
    echo "Packer was already installed, skipping..."
    exit 0
fi
