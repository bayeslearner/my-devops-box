#!/bin/bash -e

HOME=/home/ansible

if ! $(id -u ansible >/dev/null 2>&1) ; then 
    # create ansible user
    sudo useradd -p $(openssl passwd -1 ansible) --create-home -s /bin/bash ansible
    # add ansible user to ansible group
    sudo usermod -a -G ansible ansible

    # add it to sudoers
    echo "
    Defaults:ansible  !requiretty
    ansible   ALL=(ALL)   NOPASSWD: ALL
    " | sudo tee /etc/sudoers.d/ansible

    # validate
    sudo visudo -cf /etc/sudoers.d/ansible 
fi

# set ssh keys
sudo mkdir -p $HOME/.ssh/
echo "$ANSIBLE_PRIVKEY_CONTENT" | sudo tee $HOME/.ssh/$ANSIBLE_PRIVKEY_NAME > /dev/null
sudo chmod 600 $HOME/.ssh/$ANSIBLE_PRIVKEY_NAME
echo "$ANSIBLE_PUBKEY_CONTENT" | sudo tee -a $HOME/.ssh/authorized_keys > /dev/null
sudo chmod 600 $HOME/.ssh/authorized_keys

# refresh permissions
sudo chown -R ansible:ansible $HOME

# fix /etc/hosts. See: https://github.com/hashicorp/vagrant/issues/7263
ip_address=$(ip addr show eth1 | grep -w inet | awk '{ sub("/.*", "", $2); print $2 }')
sudo sed -i "/$HOSTNAME/c\\$ip_address\t$HOSTNAME" /etc/hosts
