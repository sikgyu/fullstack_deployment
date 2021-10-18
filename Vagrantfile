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

    config.vm.boot_timeout = 6000

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
        backend.vm.provision "ansible" do |ansible|
            ansible.playbook = "backend.yaml"
        end

    end

    config.vm.define "frontend" do |frontend|
        frontend.vm.provider "virtualbox" do |vb|
            vb.name = "FRONTEND"
            vb.memory = 2048
        end
        frontend.vm.hostname = "frontend.bcit.local"
	    frontend.vm.network "private_network", ip: "192.168.150.11"
        frontend.vm.network "forwarded_port", guest: 80, host: 8080
        frontend.vm.provision "ansible" do |ansible|
            ansible.playbook = "frontend.yaml"
        end
    end
end
