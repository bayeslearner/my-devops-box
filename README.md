# DevOps box
* A vagrant project with an Ubuntu 18.04 LTS box with the tools needed to practise and operate as a DevOps

# Tools included
* Docker & docker-compose
* Terraform
* Packer
* Ansible
* Git
* AWS client
* GlusterFS client

## Run commands examples :

All provisionners (except AWS client)
```bash
vagrant up 
```

Packer and Terraform 
```bash
vagrant up --provision-with common,packer,terraform
```

Only Docker 
```bash
vagrant up --provision-with common,docker
```

Only AWS client 
```bash
vagrant up --provision-with common,aws-cli
```

Ansible lab example 
```bash
vagrant up --provision-with common,file,ansible,ansible-post-install
# Boot the inventory machines
cd lab-ansible/
Vagrant up
```

Ansible with AWX 
```bash
vagrant up --provision-with common,file,ansible,ansible-post-install,docker,awx
# Boot the inventory machines
cd lab-ansible/
Vagrant up
```

## Enable GlusterFS client

- Copy gluster .dist files and edit them with your own configuration
```bash
cp config/gluster.conf.dist config/gluster.conf
cp config/gluster.hosts.dist config/hosts.conf
```
- Start VM
```bash
vagrant up --provision-with common,file,glusterfs-cli
```
