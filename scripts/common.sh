#!/bin/bash -eu

export DEBIAN_FRONTEND=noninteractive

# install common packages
apt-get update
apt-get install -y apt-transport-https ca-certificates software-properties-common \
    unzip git curl jq dos2unix telnet nmap > /dev/null
