#!/bin/bash

# check if ansible is installed
if [ -x "$(command -v ansible)" ] ; then
    ln -sf /vagrant/ansible $HOME
    ansible-galaxy install -r $HOME/ansible/requirements.yml
    sed -i "s/#deprecation_warnings = True/deprecation_warnings = False/g" /etc/ansible/ansible.cfg
else
    echo "Ansible needs to be installed!"
    exit 1
fi