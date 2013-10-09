# -*- mode: ruby -*-
# vi: set ft=ruby :

$bootstrap_script = <<SCRIPT
wget --quiet http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get -y install puppet
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.box = "precise64"

  config.vm.provision :shell, :inline => $bootstrap_script
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
  end


  config.vm.provider "virtualbox" do |v, override|
    v.gui = true
    override.cache.auto_detect = true
  end

  config.vm.provider :rackspace do |rs, override|
    override.vm.box = "dummy"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
    rs.public_key_path = "~/.ssh/id_rsa.pub"
    rs.username = ENV['RAX_USERNAME']
    rs.api_key  = ENV['RAX_API_KEY']
    rs.image    = 'Ubuntu 12.04 LTS (Precise Pangolin)'
  end
end
