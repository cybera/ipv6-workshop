
Vagrant.configure("2") do |config|
  config.vm.box = "CentOS 5.5"
  config.vm.box_url = "https://s3.amazonaws.com/Vagrant_BaseBoxes/centos-5.5-x86_64-201306301713.box"

  # Be sure to use this same subnet on other hosts.
  config.vm.network :private_network, ip: "192.168.123.55"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision 'shell', path: 'centos-bootstrap.sh'
  #config.vm.provision :puppet do |puppet|
  #  puppet.manifests_path = 'puppet/manifests'
  #  puppet.manifest_file = 'site.pp'
  #  puppet.module_path = 'puppet/modules_vagrant'
  #end
end
