#!/bin/bash -eux

if ! [ -x "$(command -v python)" ] ; then
  sudo apt-get install -yq python
fi
