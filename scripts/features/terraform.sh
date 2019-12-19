#!/bin/bash -eu

VERSION=${version:-"0.12.18"}

# install terraform
if ! which terraform > /dev/null ; then
    wget -q https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip
    unzip -o terraform_${VERSION}_linux_amd64.zip -d /usr/local/bin
    rm terraform_${VERSION}_linux_amd64.zip
else
    echo "Terraform was already installed, skipping..."
    exit 0
fi
