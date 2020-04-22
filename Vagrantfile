# -*- mode: ruby -*-
# vi: set ft=ruby :

# Version constraints
VAGRANTFILE_API_VERSION ||= "2"
Vagrant.require_version '>= 2.2.7'

# Local variables
confDir     = File.expand_path(File.dirname(__FILE__))
configFile  = confDir + "/config.yaml"
aliasesFile = confDir + "/aliases"

# Imports
require confDir + '/scripts/provision.rb'
require 'yaml'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# load YAML configuration file for extra features
	if File.exist? configFile then
        settings = YAML::load(File.read(configFile))
    else
        abort "Config file not found in #{confDir}"
    end

    # import aliases
    if File.exist? aliasesFile then
        config.vm.provision "file", source: aliasesFile, destination: "/tmp/bash_aliases"
        config.vm.provision "shell" do |s|
            s.name = "Copy aliases to ~/.bash_aliases"
            s.inline = <<-SHELL 
                awk '{ sub(\"\r$\", \"\"); print }' /tmp/bash_aliases > /home/vagrant/.bash_aliases 
                chown vagrant:vagrant /home/vagrant/.bash_aliases
                rm -f /tmp/bash_aliases
            SHELL
        end
    end

	Provision.init(config, settings)
end
