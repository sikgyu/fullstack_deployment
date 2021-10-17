#!/usr/bin/bash

sudo mkdir frontend
sudo git clone https://github.com/bezkoder/react-crud-web-api.git /home/vagrant/frontend
cd frontend/

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y npm
sudo npm install
sudo npm run-script build

sudo apt -y install nginx

sudo cp /home/vagrant/default /etc/nginx/sites-enabled/default
sudo cp /home/vagrant/http-common.js /home/vagrant/frontend/src/http-common.js

sudo systemctl restart nginx

sudo npm run-script build
