# -*- mode: ruby -*-
# vi: set ft=ruby :

# Version constraints
VAGRANTFILE_API_VERSION ||= "2"
Vagrant.require_version '>= 2.2.7'

# Local variables
confDir = File.expand_path(File.dirname(__FILE__))
configFile = confDir + "/config.yaml"

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

	Provision.init(config, settings)
end
