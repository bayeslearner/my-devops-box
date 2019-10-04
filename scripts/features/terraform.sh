#!/bin/bash -eu

VERSION=${TERRAFORM_VERSION:-"0.12.7"}

# install terraform
if ! which terraform > /dev/null ; then
    wget -q https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip
    unzip -o terraform_${VERSION}_linux_amd64.zip -d /usr/local/bin
    rm terraform_${VERSION}_linux_amd64.zip
else
    echo "Terraform was already installed, skipping..."
    exit 0
fi
