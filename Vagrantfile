# -*- mode: ruby -*-
# vi: set ft=ruby :

# constants
PLUGINS = ['vagrant-vbguest']
VAGRANTFILE_API_VERSION ||= "2"

# requirements
Vagrant.require_version '>= 2.2.9'

# Local variables
confDir         = File.expand_path(File.dirname(__FILE__))
configFile      = confDir + "/config.yaml"
aliasesFile     = confDir + "/aliases"
afterScriptPath = confDir + "/after.sh"

# Imports
require confDir + '/scripts/provision.rb'
require 'yaml'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # Vagrant will require these plugins be installed and available for the project.
    # If the plugins are not available, it will attempt to automatically install them into the local project. 
    # https://www.vagrantup.com/docs/vagrantfile/vagrant_settings#config-vagrant-plugins 
    config.vagrant.plugins = PLUGINS

    # configure vbguest plugin
    config.vbguest.auto_update = false

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
    
    if File.exist? afterScriptPath then
        config.vm.provision 'Executing after.sh script',
        type: 'shell',
        path: afterScriptPath,
        privileged: false,
        keep_color: true
    end
end
