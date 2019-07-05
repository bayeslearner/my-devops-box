#!/bin/bash

HOSTFILE=/home/vagrant/ansible/hosts

# check if ansible is installed
if ! [ -x "$(command -v ansible)" ] ; then
    echo "Ansible needs to be installed before this script!"
    exit 1
fi

# feed hosts file
if [ -f $HOSTFILE ] ; then
    cat $HOSTFILE | sudo tee -a /etc/hosts > /dev/null
fi
    
# copy ansible ssh key from host to guest
echo "$1" | sudo tee $HOME/.ssh/$2 > /dev/null
sudo chmod 600 $HOME/.ssh/$2
# chown vagrant:vagrant /home/vagrant/.ssh/$2

# set it as a default key for vagrant user 
echo "
[defaults]
remote_user = ansible
private_key_file = ~/.ssh/ansible_id_rsa
host_key_checking = False
inventory = ~/ansible/inventory
interpreter_python = /usr/bin/python
" | sudo tee $HOME/.ansible.cfg

# refresh user permissions
sudo chown -R vagrant:vagrant $HOME
