#!/bin/bash -eu

# install terraform
if ! which terraform > /dev/null ; then
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
else
    echo "Terraform was already installed, skipping..."
    exit 0
fi
