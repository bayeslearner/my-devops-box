# DevOps box
A vagrant project with an Ubuntu 18.04 LTS box with the tools needed to practise and operate as a DevOps

# Tools included
* Git
* Curl
* Telnet
* Nmap

# Features available
* AWS client
* Docker (with docker-compose)
* Terraform
* Packer
* Ansible
* AWX

## Getting started :
Call the init script to generate your own YAML configuration file
```bash
~$ ./init.sh
```

Then fill the generated `config.yaml` with your own values : VM settings, shared folders, environment variables...

## Features setup examples :
Packer and Terraform 
```yml
features:
    ...
    - packer: true
    - terraform: true
    ...
```

Ansible with AWX 
```yml
features:
    ...
    - ansible: true
    - docker: true
    - awx: true
    ...
```

Then proceed to boot the VM :
```bash
vagrant up
```

## Configure AWX installation
Before running the `vagrant up` command, edit the `awx_inventory` file with your own settings. The file will be copied over the **installer/** directory of awx source repository, replacing the [default configuration file](https://github.com/ansible/awx/blob/devel/installer/inventory).

## Boot a Vagrant lab
See: [lab/README.md](./lab/README.md)