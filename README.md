# fullstack_deployment

1. Create admin

useradd -m -d /home/admin admin
sudo usermod -aG sudo admin

2. Set admin password and nopasswd

sudo passwd admin

sudo vi /etc/sudoers
## Config NOPASSWD in sudo like this
%sudo ALL=(ALL:ALL) NOPASSWD: ALL

3. copy ssh key

wsl
ssh-keygen -t rsa -f PRIVATE_KEY
man ssh-copy-id
ssh-copy-id -i PRIVATE_KEY.pub -p 5022 admin@localhost (set ssh network in your VM)

