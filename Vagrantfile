# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

HOSTNAME = "nodo0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

 config.vm.define HOSTNAME do |srv|

    srv.vm.box = "debian/jessie64"

    srv.vm.network "private_network", ip: "192.168.33.11"
    #srv.vm.boot_timeout = 3600
    srv.vm.box_check_update = false
    srv.ssh.forward_agent = true
    srv.vm.hostname = HOSTNAME

    # En falso para usar Wheezy en 2019, con los repos en Debian Archive
    srv.vbguest.auto_update = false

    srv.vm.synced_folder ".", "/vagrant", type: "virtualbox", disabled: true


    srv.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "1024"

      # https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm mas parametros para personalizar en VB
    end
  end

    ##
    # Aprovisionamiento
    #
    config.vm.provision "fix-no-tty", type: "shell" do |s|  # http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end
    config.vm.provision "os-setup",    type: :shell, path: "os-setup.sh", privileged: true
    config.vm.provision "ssh_pub_key", type: :shell do |s|
      begin
          ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
          s.inline = <<-SHELL
            mkdir -p /root/.ssh/
            touch /root/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
          SHELL
      rescue
          puts "No hay claves publicas en el HOME de su pc"
          s.inline = "echo OK sin claves publicas"
      end
    end

end
