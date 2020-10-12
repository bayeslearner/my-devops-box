#!/bin/bash -ux

# install awscli
if ! [ -x "$(command -v aws)" ] ; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
  unzip /tmp/awscliv2.zip
  bash ./aws/install
else
  echo "AWS cli was already installed, skipping..."
  exit 0
fi
