# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	# General settings
	config.vm.box = "rgsystems/xenial64"
	config.vm.hostname = "devops-box"

	# SSH Settings
	config.ssh.forward_agent = true
	config.ssh.insert_key = false
	config.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key"]

	# Network settings
	config.vm.network "private_network", ip: "192.168.10.20"

	config.vm.provider "virtualbox" do |vb|
		vb.name = "devops-box"
		vb.memory = 4096
		vb.cpus = 2
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--ioapic", "on"]
		vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	end

	# Env vars
	vars = {
		"TERRAFORM_VERSION" => "0.12.2",
		"PACKER_VERSION" => "1.4.1",
		"DOCKER_COMPOSE_VERSION" => "1.24.0"
	}
	
	# Vagrantfile vars
	confDir = File.expand_path(File.dirname(__FILE__))
	glusterVolumes = confDir + '/config/gluster.conf'
	glusterHosts = confDir + '/config/gluster.hosts'
	ansible_privkey = "~/.ssh/ansible_id_rsa"

	# Loading environment variables to /etc/profile.d/vagrant_env.sh
	as_str = vars.map { |k, str| ["export #{k}=#{str.gsub "$", "\$"}"] }.join("\n")
	config.vm.provision "shell", inline: "echo \"#{as_str}\" > /etc/profile.d/vagrant_env.sh", run: "always"

	# Provisioning
	config.vm.provision "common", type: "shell" do |s|
		s.name = "Installing common packages"
		s.path = "scripts/common.sh"
	end

	config.vm.provision "ansible", type: "shell" do |s|
		s.name = "Installing Ansible"
		s.path = "scripts/ansible.sh"
	end

	config.vm.provision "ansible-post-install", type: "shell", run: "once" do |s|
		if File.exist? File.expand_path(ansible_privkey)
			config.vm.synced_folder "ansible/", "/home/vagrant/ansible", create: true 
			s.name = "Configuring Ansible"
			s.path = "scripts/config-ansible.sh"
			s.privileged = false
			s.args = [File.read(File.expand_path(ansible_privkey)), ansible_privkey.split('/').last]
		else
			puts "ansible ssh private key not found. Skipping..."
		end
	end
	
	config.vm.provision "docker", type: "shell" do |s|
		s.name = "Installing docker & docker-compose"
		s.path = "scripts/docker.sh"
	end

	config.vm.provision "packer", type: "shell" do |s|
		s.name = "Installing Packer"
		s.path = "scripts/packer.sh"
	end

	config.vm.provision "terraform", type: "shell" do |s|
		s.name = "Installing Terraform"
		s.path = "scripts/terraform.sh" 
	end

	# vagrant up --provision-with common,aws-cli
	config.vm.provision "aws-cli", type: "shell", run: "never" do |s|
		s.name = "Installing AWS cli"
		s.path = "scripts/aws-cli.sh"
	end

	# vagrant up --provision-with common,file,glusterfs-cli
	if File.exist?(glusterVolumes) && File.exist?(glusterHosts) then
		config.vm.provision "file", source: glusterHosts, destination: "/tmp/hosts.conf"
		config.vm.provision "file", source: glusterVolumes, destination: "/tmp/gluster.conf"
		config.vm.provision "glusterfs-cli", type: "shell", run: "never" do |s|
			s.name = "Installing GlusterFS cli"
			s.path = "scripts/gluster-cli.sh"
		end
	end

end
