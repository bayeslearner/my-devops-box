#!/bin/bash -ux

# install awscli
if ! [ -x "$(command -v aws)" ] ; then
  alias python=python3.5
  sudo apt-get install -y python3-pip
  pip3 install --upgrade pip==9.0.3
  pip3 install awscli
else
  echo "AWS cli was already installed, skipping..."
  exit 0
fi