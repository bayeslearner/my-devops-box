#!/bin/bash -eu

VERSION=${version:-"1.6.0"}

# install packer
if ! which packer > /dev/null ; then
    wget -q https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_linux_amd64.zip
    unzip -o packer_${VERSION}_linux_amd64.zip -d /usr/local/bin
    rm packer_${VERSION}_linux_amd64.zip
else
    echo "Packer was already installed, skipping..."
    exit 0
fi
