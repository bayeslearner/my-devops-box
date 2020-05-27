#!/bin/bash -e 

VERSION=${version:-"2.2.9"}

if ! which vagrant > /dev/null ; then
    # Install dependencies
    apt-get update
    apt-get install -y bridge-utils dnsmasq-base ebtables libvirt-bin libvirt-dev qemu-kvm qemu-utils ruby-dev

    # Download Vagrant & Install Vagrant package
    wget -qO /tmp/vagrant_${VERSION}_x86_64.deb https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_x86_64.deb
    dpkg -i /tmp/vagrant_${VERSION}_x86_64.deb
    vagrant --version

    # Install vagrant-libvirt Vagrant plugin
    sudo -H -u vagrant \
        vagrant plugin install vagrant-libvirt && \
        vagrant plugin list

    usermod -aG libvirt vagrant

    # Verify CPU support
    egrep '(vmx|svm)' /proc/cpuinfo
    lsmod | egrep 'kvm'
else
    echo "vagrant was already installed, skipping..."
    exit 0
fi
