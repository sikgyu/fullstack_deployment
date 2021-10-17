$script = <<-SCRIPT
sudo mv deploy.service /etc/systemd/system/deploy.service
sudo systemctl daemon-reload
sudo systemctl enable deploy
sudo systemctl start deploy
sudo systemctl restart nginx
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"

    config.vm.synced_folder ".", "/vagrant", disabled: true

    config.vm.boot_timeout = 600

    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.linked_clone = true
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    end

    config.vm.define "backend" do |backend|
        backend.vm.provider "virtualbox" do |vb|
            vb.name = "BACKEND"
            vb.memory = 1536
        end
        backend.vm.hostname = "backend.bcit.local"
        backend.vm.network "private_network", ip: "192.168.150.10"
	backend.vm.network "forwarded_port", guest: 80, host: 8080
        backend.vm.provision "file", source: "./files/backend/db_init.sql", destination: "/home/vagrant/db_init.sql"
        backend.vm.provision "file", source: "./files/backend/db.config.js", destination: "/home/vagrant/db.config.js"
        backend.vm.provision "file", source: "./files/backend/deploy.service", destination: "/home/vagrant/deploy.service"
        backend.vm.provision "shell", path: "./files/backend/backend_setup.sh"
        backend.vm.provision "shell", inline: $script
    end

    config.vm.define "frontend" do |frontend|
        frontend.vm.provider "virtualbox" do |vb|
            vb.name = "FRONTEND"
            vb.memory = 2048
        end
        frontend.vm.hostname = "frontend.bcit.local"
	frontend.vm.network "private_network", ip: "192.168.150.11"
        frontend.vm.network "forwarded_port", guest: 80, host: 8090
        frontend.vm.provision "file", source: "./files/frontend/default", destination: "/home/vagrant/default"
        frontend.vm.provision "file", source: "./files/frontend/http-common.js", destination: "/home/vagrant/http-common.js"
        frontend.vm.provision "shell", path: "./files/frontend/frontend_setup.sh"
    end
end
