# -*- mode: ruby -*-
# vi: set ft=ruby :

# Defining Oracle Proxy / Use Case Flags
load './vagrant-addons/ProxyConfigfile'

# Plugin installation procedure from http://stackoverflow.com/a/28801317
# This will load by default proxyconf to allow the client access to the proxy.
required_plugins = %w(vagrant-proxyconf vagrant-disksize)
#
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end
# Completed Defining Some Oracle / Use Case Flags

# Display Message so users know how to access the demo.
$msg = <<MSG_EOF
------------------------------------------------------
Vagrant Docker Demo

List:
- C:\> vagrant status
Access:
- C:\> vagrant ssh

------------------------------------------------------
MSG_EOF

##############################################################################

Vagrant.configure("2") do |config|

  # This demo will use Oracle Linux 7 server image.

  # You can search for boxes from the Vagrant Cloud at https://vagrantcloud.com/search
  # config.vm.box = "oravirt/ol73"
  # config.vm.box = "oravirt/ol74"

  # or Oracle Linux boxes at http://yum.oracle.com/boxes
  config.vm.box_url = "http://yum.oracle.com/boxes/oraclelinux/ol74/ol74.box"
  config.vm.box = "ol74"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
    # Change the network adapter to promiscuous mode
    vb.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
    vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
  end

  # Share an additional folder to the guest VM, default is "share" in the current directory.
  config.vm.synced_folder "vagrant-share", "/vagrant-share"

  # Enable provisioning of the client with a shell script.
  config.vm.provision "shell", path: "./vagrant-shell/provision.sh"

  # Enable provisioning of OpenVSwitch with a shell script.
  #config.vm.provision "shell", path: "./vagrant-shell/openvswitch.sh"

  # Enable provisioning of docker with a shell script.
  config.vm.provision "shell", path: "./vagrant-shell/docker.sh"

  # Enable provisioning of Demo with a shell script.
  config.vm.provision "shell", path: "./vagrant-shell/demo.sh"

  config.vm.provision "shell", path: "./vagrant-shell/ipv6-test.sh"

end
