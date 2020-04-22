#!/bin/bash -eu

DISTRIBUTION_RELEASE=$(lsb_release -sc)
IP=$1
DNS_IP=$2
DNS_DOMAIN=$3

echo "==> Setting DNS for ${DISTRIBUTION_RELEASE}..."

# Ubuntu bionic
if [ ${DISTRIBUTION_RELEASE} == 'bionic' || ${DISTRIBUTION_RELEASE} == 'disco' ] ; then
block="
---
network:
  version: 2
  renderer: networkd
  ethernets:
    eth1:
      addresses:
      - ${IP}/24
      nameservers:
        addresses: [${DNS_IP}]
        search: [${DNS_DOMAIN}]
"
echo "${block}" | sudo tee /etc/netplan/50-vagrant.yaml >/dev/null 2>&1
sudo netplan apply 
fi

# Debian buster
if [ ${DISTRIBUTION_RELEASE} == 'buster' ] || [ ${DISTRIBUTION_RELEASE} == 'stretch' ] ; then
    if [ ! -d /etc/default/resolvconf ] ; then 
        echo "Installing DNS management tools..."
        sudo apt-get update > /dev/null
        sudo apt-get install -y dnsutils resolvconf > /dev/null
    fi

    if [ ! -L /etc/resolv.conf ]; then 
        ln -s /etc/resolvconf/run/resolv.conf /etc/resolv.conf
    fi

    # Delete any preexisting dns settings
    sudo sed -i '/^dns/d' /etc/network/interfaces

    # Append DNS configs
    sudo sed -i "/#VAGRANT-END/a dns-nameserver\t$DNS_IP\ndns-search\t$DNS_DOMAIN\n" /etc/network/interfaces

    # Refresh config
    sudo ifdown eth1 && sudo ifup eth1
fi
