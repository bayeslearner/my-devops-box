#!/bin/bash -e 

if which VBoxManage > /dev/null ; then
    # Install VirtualBox
    wget -q -O- http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc | sudo apt-key add -
    echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    apt-get update
    apt-get install virtualbox-6.1
    usermod -aG vboxusers vagrant
    VBoxManage --version
fi
