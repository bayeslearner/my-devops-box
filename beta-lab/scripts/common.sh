#!/bin/bash -eux

HOME=/home/ansible

# create ansible user
sudo useradd -p $(openssl passwd -1 ansible) --create-home -s /bin/bash ansible

# add it to sudoers
echo "ansible        ALL=(ALL)       NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# set ssh keys
sudo mkdir $HOME/.ssh/
echo "$ANSIBLE_PRIVKEY_CONTENT" | sudo tee $HOME/.ssh/$ANSIBLE_PRIVKEY_NAME
sudo chmod 600 $HOME/.ssh/$ANSIBLE_PRIVKEY_NAME
echo "$ANSIBLE_PUBKEY_CONTENT" | sudo tee $HOME/.ssh/authorized_keys
sudo chmod 600 $HOME/.ssh/authorized_keys

# refresh permissions
sudo chown -R ansible:ansible $HOME
