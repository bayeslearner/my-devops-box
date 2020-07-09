# DevOps box

A vagrant project with an Ubuntu 18.04 LTS box with the tools needed to practise and operate as a DevOps

- [DevOps box](#devops-box)
  - [Tools included](#tools-included)
  - [Features available](#features-available)
  - [Getting started](#getting-started)
  - [Features setup examples](#features-setup-examples)
  - [Configure AWX installation](#configure-awx-installation)
  - [Boot a multi-VMs Vagrant lab](#boot-a-multi-vms-vagrant-lab)
    - [Dependencies](#dependencies)

## Tools included

* Git
* Curl
* Telnet
* Nmap

## Features available

* AWS client
* Docker (with docker-compose)
* Terraform
* Packer
* Ansible
* AWX
* Vagrant (with libvirt plugin)
* VirtualBox (for nested virtualization)

## Getting started

Call the init script to generate your own YAML configuration file
```bash
~$ ./init.sh
```

Then fill the generated `config.yaml` with your own values : VM settings, shared folders, environment variables...

## Features setup examples

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

Choosing a specific version
```yml
features:
    ...
    - terraform: true
      version: "0.12.7"
    - awx: true
      version: "9.0.1"
```

Then proceed to boot the VM :
```bash
vagrant up
```

## Configure AWX installation

Before running the `vagrant up` command, edit the `awx_inventory` file with your own settings. The file will be copied over the **installer/** directory of awx source repository, replacing the [default configuration file](https://github.com/ansible/awx/blob/devel/installer/inventory).

## Boot a multi-VMs Vagrant lab

This repository allows to boot up multiple, ansible-ready VMs using pre-defined YAML files. To initialize a new lab : 

1. Move into lab/ directory : `cd lab/`
2. Copy or edit one of the existing YAML servers definition files found in resources/.
3. Copy `.env.dist` to `.env`. Add key `CONFIG_PATH=<your_file.yml>`. For example, `CONFIG_FILE=resources/postgresql.yml`
4. Ensure your configuration is valid using command `vagrant validate`
5. Start your lab using `vagrant up`

### Dependencies 

The Vagrantfile used to boot up labs automatically installs the following vagrant plugins :
- [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager)
- [vagrant-env](https://github.com/gosuri/vagrant-env)
