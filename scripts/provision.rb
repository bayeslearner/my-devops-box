class Provision
    def self.init(config, settings)
      # Set The VM Provider
      ENV['VAGRANT_DEFAULT_PROVIDER'] = settings['provider'] ||= 'virtualbox'
  
      # Configure Local Variable To Access Scripts From Remote Location
      script_dir = File.dirname(__FILE__)
  
      # Allow SSH Agent Forward from The Box
      config.ssh.forward_agent = true
      config.ssh.insert_key = false
  
      # Configure The Box
      config.vm.box =         settings['box'] ||= 'rgsystems/focal64'
      config.vm.hostname =    settings['hostname'] ||= 'rg-devops-box'
      config.vm.box_version = settings['version'] ||= '>=1.0.0'
      config.vm.define        settings['name'] ||= 'rg-devops-box'
  
       # Configure A Private Network IP
      if settings['ip'] != 'autonetwork'
        config.vm.network :private_network, ip: settings['ip'] ||= '192.168.10.10'
      else
        config.vm.network :private_network, ip: '0.0.0.0', auto_network: true
      end
  
      # Configure Additional Networks
      if settings.key?('networks')
        settings['networks'].each do |network|
          config.vm.network network['type'], ip: network['ip'], bridge: network['bridge'] ||= nil, netmask: network['netmask'] ||= '255.255.255.0'
        end
      end
  
      # Configure A Few VirtualBox Settings
      config.vm.provider 'virtualbox' do |vb|
        vb.name = settings['name'] ||= 'rg-devbox'
        vb.customize ['modifyvm', :id, '--memory', settings['memory'] ||= '2048']
        vb.customize ['modifyvm', :id, '--cpus', settings['cpus'] ||= '1']
        vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
        vb.customize ['modifyvm', :id, '--natdnspassdomain1', settings['natdnspassdomain'] ||= 'on']
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', settings['natdnshostresolver'] ||= 'on']
        vb.customize ["modifyvm", :id, "--ioapic", "on"] # necessary for 2 or more vcpus
        vb.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
        vb.gui = true if settings.key?('gui') && settings['gui']
      end
  
      # Override Default SSH port on the host
      if settings.key?('default_ssh_port')
        config.vm.network :forwarded_port, guest: 22, host: settings['default_ssh_port'], auto_correct: false, id: 'ssh'
      end
  
      # Standardize Ports Naming Schema
      if settings.key?('ports')
        settings['ports'].each do |port|
          port['guest'] ||= port['to']
          port['host'] ||= port['send']
          port['protocol'] ||= 'tcp'
        end
      else
        settings['ports'] = []
      end
  
      # Default Port Forwarding
      default_ports = {
        80 => 8000,
        443 => 44_300,
        3306 => 33_060,
        4040 => 4040,
        5432 => 54_320,
        8025 => 8025,
        27_017 => 27_017
      }
  
      # Use Default Port Forwarding Unless Overridden
      unless settings.key?('default_ports') && settings['default_ports'] == false
        default_ports.each do |guest, host|
          unless settings['ports'].any? { |mapping| mapping['guest'] == guest }
            config.vm.network 'forwarded_port', guest: guest, host: host, auto_correct: true
          end
        end
      end
  
      # Add Custom Ports From Configuration
      if settings.key?('ports')
        settings['ports'].each do |port|
          config.vm.network 'forwarded_port', guest: port['guest'], host: port['host'], protocol: port['protocol'], auto_correct: true
        end
      end
  
      # Configure The Public Key For SSH Access
      if settings.include? 'authorize'
        if File.exist? File.expand_path(settings['authorize'])
          config.vm.provision 'shell' do |s|
            s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo \"\n$1\" | tee -a /home/vagrant/.ssh/authorized_keys"
            s.args = [File.read(File.expand_path(settings['authorize']))]
          end
        end
      end
  
      # Copy The SSH Private Keys To The Box
      if settings.include? 'keys'
        if settings['keys'].to_s.length.zero?
          puts 'Check your config.yaml file, you have no private key(s) specified.'
          exit
        end
        settings['keys'].each do |key|
          if File.exist? File.expand_path(key)
            config.vm.provision 'shell' do |s|
              s.privileged = false
              s.inline = 'echo "$1" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2'
              s.args = [File.read(File.expand_path(key)), key.split('/').last]
            end
          else
            puts 'Check your config.yaml file, the path to your private key does not exist.'
            exit
          end
        end
      end
  
      # Copy User Files Over to VM
      if settings.include? 'copy'
        settings['copy'].each do |file|
          config.vm.provision 'file' do |f|
            f.source = File.expand_path(file['from'])
            f.destination = file['to'].chomp('/') + '/' + file['from'].split('/').last
          end
        end
      end
  
      # Register All Of The Configured Shared Folders
      if settings.include? 'folders'
        settings['folders'].each do |folder|
          if File.exist? File.expand_path(folder['map'])
            mount_opts = []
  
            if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'hyperv'
              folder['type'] = 'smb'
            end
  
            if folder['type'] == 'nfs'
              mount_opts = folder['mount_options'] ? folder['mount_options'] : ['actimeo=1', 'nolock']
            elsif folder['type'] == 'smb'
              mount_opts = folder['mount_options'] ? folder['mount_options'] : ['vers=3.02', 'mfsymlinks']
  
              smb_creds = {'smb_host': folder['smb_host'], 'smb_username': folder['smb_username'], 'smb_password': folder['smb_password']}
            end
  
            # For b/w compatibility keep separate 'mount_opts', but merge with options
            options = (folder['options'] || {}).merge({ mount_options: mount_opts }).merge(smb_creds || {})
  
            # Double-splat (**) operator only works with symbol keys, so convert
            options.keys.each{|k| options[k.to_sym] = options.delete(k) }
  
            config.vm.synced_folder folder['map'], folder['to'], type: folder['type'] ||= nil, **options
  
            # Bindfs support to fix shared folder (NFS) permission issue on Mac
            if folder['type'] == 'nfs' && Vagrant.has_plugin?('vagrant-bindfs')
              config.bindfs.bind_folder folder['to'], folder['to']
            end
          else
            config.vm.provision 'shell' do |s|
              s.inline = ">&2 echo \"Unable to mount one of your folders. Please check your folders in config.yaml\""
            end
          end
        end
      end
      
      # Configure All Of The Server Environment Variables
      config.vm.provision 'shell' do |s|
        s.name = 'Clear Variables'
        s.path = script_dir + '/clear-variables.sh'
      end
  
      if settings.key?('variables')
        settings['variables'].each do |var|
          config.vm.provision 'shell' do |s|
            s.inline = "echo \"\n# Set DevOps Box Environment Variable\nexport $1=$2\" >> /home/vagrant/.profile"
            s.args = [var['key'], var['value']]
          end
        end
      end

      # Install common features
      config.vm.provision "common", type: "shell" do |s|
        s.name = "Installing common packages"
        s.path = "scripts/common.sh"
      end
    
      # Creates folder for opt-in features lockfiles
      config.vm.provision "shell", inline: "mkdir -p /home/vagrant/.devops-features"
      config.vm.provision "shell", inline: "chown -Rf vagrant:vagrant /home/vagrant/.devops-features"
      
      # Install opt-in features
      if settings.has_key?('features')
        settings['features'].each do |feature|
          feature_name = feature.keys[0]
          feature_variables = feature[feature_name]
          feature_path = script_dir + "/features/" + feature_name + ".sh"
  
          # Check for boolean parameters
          # Compares against true/false to show that it really means "<feature>: <boolean>"
          if feature_variables == false
            config.vm.provision "shell", inline: "echo Ignoring feature: #{feature_name} because it is set to false \n"
            next
          elsif feature_variables == true
            # If feature_arguments is true, set it to empty, so it could be passed to script without problem
            feature_variables = {}
          end
  
          # Check if feature really exists
          if !File.exist? File.expand_path(feature_path)
            config.vm.provision "shell", inline: "echo Invalid feature: #{feature_name} \n"
            next
          end
  
          config.vm.provision "shell" do |s|
            s.name = "Installing " + feature_name
            s.path = feature_path
            s.env = feature
          end
        end
      end
            
      # DNS
      if settings.include? 'dns' then
        config.vm.provision 'shell' do |s|
          s.name = 'Updating DNS..'
          s.path = script_dir + '/set-dns.sh'
          s.args = [ 
            settings['ip'],
            settings['dns'][0]['ip'],
            settings['dns'][0]['domain'].to_s
          ]
          s.privileged = false
        end
      end

  end
end