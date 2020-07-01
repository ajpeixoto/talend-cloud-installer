VAGRANTFILE_API_VERSION = "2"
third_disk_name = "third_data_disk_" + Time.now.to_i.to_s + ".vdi"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|

    unless File.exist?(third_disk_name)
      vb.customize ["createhd", "--filename", third_disk_name, "--size", 10 * 1024]
    end
    vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--portcount', 3]
    vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 2, "--device", 0, "--type", "hdd", "--medium", third_disk_name]
  end
end
